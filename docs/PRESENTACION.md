# Presentación de CloudPulse HA — primera fase real

1. Abrir la web servida por NGINX desde EC2.
2. Mostrar el Instance ID y la zona real. Explicar que se obtuvieron mediante IMDSv2.
3. Pulsar «Comprobar ahora» y mostrar la respuesta HTTP y la hora de la comprobación.
4. Mostrar en AWS la única instancia del proyecto y el security group con puertos 22 y 80 limitados a la IP de prueba.
5. Explicar que Amazon Linux 2023, NGINX y EBS gp3 forman la primera fase del despliegue.
6. Reconocer el límite actual: una sola EC2 no ofrece redundancia. Dos instancias en zonas diferentes y un balanceador son trabajo futuro, no pruebas ya realizadas.

No presentar la página por sí sola como evidencia de Auto Scaling, de inventario de la cuenta ni de alta disponibilidad. La nueva pantalla solo contiene la identidad y comprobaciones reales; ya no incluye demo.
