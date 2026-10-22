# Validación del despliegue

| Comprobación | Resultado |
|---|---|
| Servicio NGINX | HTTP 200 · ok |
| Instance ID | `i-0a4f26278c892d1d3` |
| Zona de disponibilidad | `eu-west-1a` |
| Sistema EC2 | Check passed |
| Instancia EC2 | Check passed |
| Almacenamiento EBS | Check passed |
| Pruebas del módulo JavaScript | Aprobadas |

## Servicio web

![Identidad de la instancia y respuesta de NGINX](../evidence/cloudpulse-web.png)

## Estado de la infraestructura

![Comprobaciones de EC2 y EBS](../evidence/ec2-status-checks.png)

Las evidencias corresponden a un despliegue de una instancia EC2. No se configuraron alarmas ni comprobaciones de aplicación en AWS.
