console.log("Harry Stilos Web - Conectado de forma profesional.");
document.getElementById("btn-reservar").addEventListener("click", function () {

    const nombre = document.getElementById("nombre").value;
    const telefono = document.getElementById("telefono").value;
    const servicio = document.getElementById("servicio").value;
    const fecha = document.getElementById("fecha").value;
    const hora = document.getElementById("hora").value;
    const comentarios = document.getElementById("comentarios").value;

    if (!nombre || !telefono || !servicio || !fecha || !hora) {
        alert("Por favor completa todos los campos obligatorios.");
        return;
    }

    const mensaje =
`Hola Harry 👋

Quiero agendar una cita.

👤 Nombre: ${nombre}
📱 Teléfono: ${telefono}
✂️ Servicio: ${servicio}
📅 Fecha: ${fecha}
🕒 Hora: ${hora}

📝 Comentarios:
${comentarios}`;

    const url = "https://wa.me/573203135715?text=" + encodeURIComponent(mensaje);

    window.open(url, "_blank");

});