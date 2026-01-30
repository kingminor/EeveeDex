const typeColors = {
    Normal: "#858579",
    Fire: "#FF4526",
    Psychic: "#F95587",
    Dark: "#765647"
}


document.querySelectorAll('.pokemon-item').forEach((el) => {
    el.addEventListener('click', (e) => {
        const name = el.dataset.name;
        const number = el.dataset.number;
        const classification = el.dataset.classification;
        const generation = el.dataset.generation;
        const image = el.dataset.image;
        const sound = el.dataset.sound;
        
        document.getElementById('poke-name').innerText = `#${number}: ${name}`;
        document.getElementById('poke-info').innerText = `${classification} (Gen ${generation})`;
        
        const img = document.getElementById('poke-image');
        if (image) {
            img.src = image;
            img.style.display = 'block';
        } else {
            img.style.display = 'none';
        }

        const types = el.dataset.types.split(",");

        const typeContainer = document.getElementById("poke-types");
        typeContainer.innerHTML = "";

        types.forEach(t => {
            const span = document.createElement("span");
            span.className = "type";
            span.textContent = t;
            span.style.backgroundColor = typeColors[t] || "#777";
            typeContainer.appendChild(span);
        });


        const cryPlayer = new Audio(sound);
        cryPlayer.play();
    })
})