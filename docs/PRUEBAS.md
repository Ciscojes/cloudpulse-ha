# Pruebas y resultados

Fecha de referencia: 21 de octubre de 2026, Costa Rica. El estado de los recursos puede cambiar después de estas observaciones.

| Prueba | Resultado obtenido | Evidencia / alcance |
|---|---|---|
| Crear security group del proyecto | Verificado | `cloudpulse-estudiante-sg`; dos reglas TCP, 22 y 80, limitadas a la IP del usuario /32 |
| Lanzar EC2 | Verificado | `cloudpulse-estudiante-01`, `i-0a4f26278c892d1d3`, `t3.micro`; la consola mostró Running |
| Página NGINX por IPv4 pública | Verificado | El navegador mostró CloudPulse HA, el ID real y `eu-west-1a`; inicialmente hubo conexión rechazada durante el arranque y después funcionó |
| IMDSv2 obligatorio | Verificado | La consola mostró Required y el script de identidad empleó un token |
| Reglas asociadas a EC2 | Verificado | El grupo creado estaba asociado; HTTP 80 y SSH 22 restringidos a la IP del usuario |
| Comprobaciones de salud de AWS | Pendiente de confirmación final | Se observaron inicialmente en Initializing; no registrar Passed sin evidencia posterior |
| Ruta pública de la subnet | No inspeccionada directamente | La consola VPC no respondió a la herramienta. La web respondió desde la conexión de prueba; eso valida conectividad HTTP puntual, no una auditoría completa de rutas |
| Despliegue de la primera interfaz | Verificado por salida del usuario y confirmación visual del usuario | El instalador terminó, nginx -t pasó y /healthz devolvió ok |
| Retirada de toda la demo | Confirmada por el usuario después de actualizar | Captura guardada por el usuario; pendiente de incorporar al repositorio |
| Dos destinos saludables detrás de ALB | No ejecutada | No se crearon ALB ni segunda EC2 |
| Caída de un servidor sin pérdida prolongada de acceso | No ejecutada | Requiere al menos dos destinos saludables y prueba controlada |
| Reemplazo mediante Auto Scaling | No ejecutada | No se creó ASG |
| Eliminación de recursos | Consultar documento de cierre | No asumir limpieza sin confirmación de AWS |

## Pruebas locales de la interfaz actualizada

El registro `validacion-local.txt` contiene las comprobaciones de sintaxis y las pruebas del módulo de identidad. Incluyen identidad válida, HTTP correcto, identidad no disponible, fallo HTTP parcial, entrada inválida, nueva comprobación manual y ausencia de elementos de demo en el HTML. No sustituyen pruebas de despliegue en Amazon Linux.

## Prueba de HA pendiente, paso a paso

1. Aprobar presupuesto, tipos de instancia y duración. Confirmar restricciones del laboratorio.
2. Desplegar dos EC2 en zonas distintas con el mismo instalador.
3. Verificar individualmente `/healthz` e `/identity.json` en ambas.
4. Crear un target group HTTP:80 y un ALB en dos subnets públicas. Permitir al ALB alcanzar las EC2 por referencia de security group; limitar el origen del ALB al acceso de prueba previsto.
5. Esperar a que ambos destinos estén Healthy. Registrar IDs y zonas reales.
6. Solicitar la identidad varias veces mediante el ALB sin caché; no exigir alternancia exacta.
7. Detener una EC2, observar que el ALB la marque Unhealthy y probar que la otra siga respondiendo. Registrar cualquier error y cuánto tarda la detección; no prometer cero errores durante la transición.
8. Iniciar la EC2 detenida, actualizar su registro si corresponde y esperar Healthy. La IP pública temporal puede cambiar.
9. Si se implementa ASG, probar su reemplazo por separado. Reiniciar manualmente una EC2 no demuestra recuperación automática.
10. Guardar evidencia y eliminar exclusivamente los recursos de prueba creados para esta ejecución.
