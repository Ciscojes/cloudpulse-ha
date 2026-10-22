# Cierre del laboratorio y control de costos

## Alcance autorizado

El usuario pidió avanzar con costo reducido y eliminar los recursos de esta prueba al finalizar. No borrar la VPC predeterminada, sus subnets, tablas de rutas, Internet Gateway, clave `mi-llave`, otros grupos de seguridad ni recursos de otros laboratorios.

## Recursos creados en esta conversación

| Recurso | Identificador | Estado de limpieza |
|---|---|---|
| EC2 `cloudpulse-estudiante-01` | `i-0a4f26278c892d1d3` | No eliminada por el agente; último estado observado: Running |
| Security group `cloudpulse-estudiante-sg` | `sg-07cfeeb63bd2086c5` | No eliminado por el agente |
| Disco raíz de la EC2 | 8 GiB gp3, ID pendiente de lectura | Delete on termination estaba en Yes en el formulario; confirmar eliminación efectiva |
| IPv4 pública temporal | Asignada automáticamente | Se libera con la terminación de la EC2; confirmar estado de la instancia |

No se crearon segunda EC2, ALB, NAT Gateway, ASG, snapshots ni Elastic IPs durante este avance.

**Limpieza bloqueada:** la conexión de control con Edge dejó de responder y devolvió errores de conexión al depurador. Los intentos de volver a leer la instancia no permitieron alcanzar ni verificar una operación de eliminación. No se pulsó Terminate ni Delete. La EC2 y su disco pueden seguir generando cargos. Es necesario reconectar la extensión y completar esta limpieza, o realizarla manualmente en la consola. No confundir una sesión de navegador desconectada con un recurso eliminado.

## Orden de limpieza

1. Comprobar que la instancia indicada sigue siendo la de este proyecto.
2. Guardar las evidencias y el código local. La página actual es la página de prueba de User Data y es reproducible; la interfaz nueva está guardada localmente.
3. Terminar exclusivamente esa instancia de prueba y esperar a que AWS muestre Terminated.
4. Confirmar que su volumen raíz ya no aparece como recurso existente. No eliminar discos de otras instancias.
5. Una vez desaparecida la interfaz de red asociada, eliminar exclusivamente el security group indicado.
6. Registrar el resultado con fecha y evidencia. Si alguna operación falla, dejarla como pendiente; no escribir que se borró todo.

## Referencia de costos

La consola mostró USD 0,0114/h para la t3.micro Linux en Irlanda. La referencia pública de IPv4 era USD 0,005/h: subtotal USD 0,0164/h más EBS y transferencia, antes de créditos o condiciones del laboratorio. Una hora equivale aproximadamente a USD 0,0164 por cómputo más IP, no al costo total de la cuenta.

No se verificó el saldo de AWS Academy, ni la factura real ni la cobertura de créditos. El modo CPU Standard evita cargos por créditos excedentes. Detener EC2 reduce consumo de cómputo pero deja el disco EBS; terminar y comprobar el disco es la limpieza final prevista.

Fuentes: https://aws.amazon.com/vpc/pricing/ y https://aws.amazon.com/ec2/pricing/on-demand/ .
