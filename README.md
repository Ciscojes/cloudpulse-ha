# CloudPulse HA

Proyecto educativo desplegado en AWS EC2 que muestra la identidad del servidor y comprueba su respuesta HTTP mediante NGINX.

## Implementación

- Una instancia EC2 `t3.micro` con Amazon Linux 2023 en `eu-west-1a`.
- NGINX para servir la interfaz HTML, CSS y JavaScript.
- Instance ID y zona obtenidos mediante IMDSv2 obligatorio.
- Comprobación HTTP de `/healthz`, con actualización manual desde la interfaz.
- Volumen raíz EBS gp3 de 8 GiB cifrado.
- Acceso HTTP y SSH restringido a la IP autorizada durante la prueba.

```mermaid
flowchart LR
  U[Navegador] -->|HTTP 80| S[Security group]
  S --> E[EC2 en eu-west-1a]
  E --> N[NGINX · CloudPulse]
```

## Resultado

La web respondió **HTTP 200 · ok** y mostró la identidad real de la instancia. Las comprobaciones de sistema, instancia y EBS de AWS terminaron en **Check passed**.

![CloudPulse desplegado en AWS](evidence/cloudpulse-web.png)

[Ver resultados y evidencia de EC2](docs/RESULTADOS.md)

## Alcance

La interfaz utiliza respuestas del servidor, sin datos simulados. No consulta el inventario ni el estado de EC2 mediante la API de AWS.

Esta fase comprende una única instancia. No incluye balanceador, Auto Scaling ni una prueba de alta disponibilidad.

**Estado:** laboratorio finalizado. La limpieza de los recursos fue confirmada por el responsable del proyecto; la web por IP pública no es una publicación permanente.

## Contenido del repositorio

- `index.html`, `styles.css`, `deployment.js`: interfaz web.
- `deploy/install-nginx.sh`: instalador del sitio para Amazon Linux 2023.
- `tests/deployment.test.cjs`: pruebas del módulo de identidad y comprobación HTTP.
- `docs/RESULTADOS.md` y `evidence/`: resultados y capturas del despliegue.
