# Cierre del laboratorio

## Resultado

El usuario confirmó haber completado la limpieza desde la consola de AWS después de recibir las instrucciones para terminar la instancia, eliminar el grupo de seguridad y comprobar el disco raíz. Esta confirmación procede del usuario; el agente no pudo verificar el estado final directamente debido a fallos de conexión.

| Recurso de prueba | Identificador | Registro final |
|---|---|---|
| EC2 cloudpulse-estudiante-01 | i-0a4f26278c892d1d3 | Limpieza confirmada por el usuario |
| Security group cloudpulse-estudiante-sg | sg-07cfeeb63bd2086c5 | Limpieza confirmada por el usuario |
| Disco raíz | 8 GiB gp3, Delete on termination = Yes | Comprobación de limpieza incluida en los pasos confirmados por el usuario; sin verificación independiente |
| IPv4 temporal | Asignación automática | Su liberación depende de la terminación efectiva de la EC2 |

La web por IP pública era temporal y no debe utilizarse como enlace permanente de presentación. El código, el instalador y las capturas del despliegue se conservan en GitHub.

## Recursos conservados

VPC predeterminada, subnets, tablas de rutas, Internet Gateway y clave mi-llave. No se indicó borrar recursos ajenos al proyecto.

Durante el laboratorio no se crearon segunda EC2, ALB, NAT Gateway, ASG, snapshots ni Elastic IPs.

## Costos

La consola mostró USD 0,0114/h para t3.micro Linux y la referencia de IPv4 pública era USD 0,005/h, más EBS y transferencia. No se verificó factura, saldo ni cobertura de créditos. No se afirma que la cuenta completa esté sin cargos: el cierre se limita a los recursos de esta prueba confirmados por el usuario.
