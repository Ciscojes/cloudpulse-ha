# CloudPulse HA

Proyecto educativo de AWS con una instancia EC2 y NGINX. La interfaz muestra únicamente datos recibidos del servidor; no incluye servidores ficticios, contadores inventados ni botones que simulen acciones de AWS.

## Pantalla actual

- Instance ID y zona obtenidos con IMDSv2 durante la instalación.
- Comprobación HTTP real de `/healthz` al abrir la página o pulsar «Comprobar ahora».
- Hora local del intento de comprobación.
- Si un dato no está disponible, se muestra «Sin verificar» o «Sin respuesta válida».

La identidad de `/identity.json` corresponde al servidor que entrega ese archivo. No es una consulta de inventario ni del estado de EC2 en AWS. La comprobación HTTP valida la entrega de `ok` por NGINX, no una consulta interna de systemd. Con una sola instancia todavía no existe alta disponibilidad.

## Despliegue

`deploy/install-nginx.sh` instala los tres archivos web en Amazon Linux 2023, obtiene la identidad mediante IMDSv2 y configura NGINX y `/healthz`. No crea infraestructura ni incluye credenciales. Retira el antiguo `script.js` de la demo del directorio web.

El instalador se ejecutó correctamente en EC2: NGINX validó la configuración y /healthz respondió ok. El usuario confirmó después la actualización de la interfaz sin simulación y guardó las capturas de la web y de la consola. Las capturas aún no están incluidas en este repositorio.

## Verificación local

```powershell
node --check deployment.js
node tests/deployment.test.cjs
```

Para una vista local: `python -m http.server 8765 --bind 127.0.0.1`. Sin los archivos de identidad y salud generados en EC2, la página mostrará datos sin verificar; no inventa respuestas.

## Documentación

- `docs/PRUEBAS.md`: resultados y pruebas pendientes.
- `docs/ARQUITECTURA.md`: arquitectura comprobada y objetivo futuro.
- `docs/PRESENTACION.md`: guion de presentación.
- `docs/CIERRE-LABORATORIO.md`: recursos de prueba y limpieza pendiente.

No publicar claves PEM, credenciales ni capturas con información privada de la cuenta. El proyecto no tiene ALB ni ASG y no se ha probado tolerancia a fallos.
