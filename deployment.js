"use strict";
(() => {
  const status = document.getElementById("deployment-status");
  const button = document.getElementById("check-server");
  const id = document.getElementById("real-id");
  const zone = document.getElementById("real-zone");
  const health = document.getElementById("real-health");
  const time = document.getElementById("real-time");
  const badge = document.getElementById("web-badge");
  async function checkServer() {
    button.disabled = true;
    status.textContent = "Consultando el servidor…";
    id.textContent = zone.textContent = "Sin verificar";
    health.textContent = "Sin comprobar";
    time.textContent = "En curso";
    badge.textContent = "Comprobando";
    badge.dataset.state = "pending";
    const options = () => ({cache: "no-store", signal: AbortSignal.timeout(8000)});
    const [identityResult, healthResult] = await Promise.allSettled([
      (async () => {
        const response = await fetch(`./identity.json?t=${Date.now()}`, options());
        if (!response.ok) throw new Error("Identidad no disponible");
        const value = await response.json();
        if (!/^i-[0-9a-f]{8,17}$/.test(value.instanceId) ||
            !/^eu-west-1[a-z]$/.test(value.availabilityZone)) throw new Error("Identidad inválida");
        return value;
      })(),
      (async () => {
        const response = await fetch(`./healthz?t=${Date.now()}`, options());
        if (!response.ok || (await response.text()).trim() !== "ok") throw new Error("Respuesta HTTP no válida");
        return response.status;
      })(),
    ]);
    if (identityResult.status === "fulfilled") {
      id.textContent = identityResult.value.instanceId;
      zone.textContent = identityResult.value.availabilityZone;
    }
    const httpOk = healthResult.status === "fulfilled";
    health.textContent = httpOk ? `HTTP ${healthResult.value} · ok` : "Sin respuesta válida";
    badge.textContent = httpOk ? "Web accesible" : "Comprobación fallida";
    badge.dataset.state = httpOk ? "ok" : "error";
    time.textContent = new Date().toLocaleString("es-CR");
    status.textContent = identityResult.status === "fulfilled" && httpOk
      ? "Identidad recibida y acceso HTTP comprobado."
      : "No se pudieron verificar todos los datos. Los campos sin verificar no representan un estado confirmado.";
    button.disabled = false;
  }
  button.addEventListener("click", checkServer);
  checkServer();
})();
