// app.js - Sistema Premium CL Book's

function somenteNumeros(valor) {
    return (valor || '').replace(/\D/g, '');
}

function aplicarMascaraCpfCnpj(campo) {
    let numeros = somenteNumeros(campo.value);

    if (numeros.length <= 11) {
        numeros = numeros.substring(0, 11);
        campo.value = numeros
            .replace(/(\d{3})(\d)/, '$1.$2')
            .replace(/(\d{3})(\d)/, '$1.$2')
            .replace(/(\d{3})(\d{1,2})$/, '$1-$2');
    } else {
        numeros = numeros.substring(0, 14);
        campo.value = numeros
            .replace(/(\d{2})(\d)/, '$1.$2')
            .replace(/(\d{3})(\d)/, '$1.$2')
            .replace(/(\d{3})(\d)/, '$1/$2')
            .replace(/(\d{4})(\d{1,2})$/, '$1-$2');
    }
}

function validarEmailFormato(email) {
    return /^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$/.test(email);
}

function prepararValidacaoUsuario() {
    const cpfCnpj = document.getElementById('cpfCnpj');
    const email = document.getElementById('email');
    const form = document.getElementById('formUsuario');

    if (cpfCnpj) {
        cpfCnpj.addEventListener('input', function () {
            aplicarMascaraCpfCnpj(this);
        });
    }

    if (form) {
        form.addEventListener('submit', function (event) {
            if (cpfCnpj && somenteNumeros(cpfCnpj.value).length < 11) {
                event.preventDefault();
                alert('CPF/CNPJ inválido.');
                cpfCnpj.focus();
                return;
            }

            if (email && !validarEmailFormato(email.value)) {
                event.preventDefault();
                alert('E-mail inválido.');
                email.focus();
            }
        });
    }
}

function prepararValidacaoLivro() {
    const valorLivro = document.getElementById('valorLivro');
    const form = document.getElementById('formLivro');

    if (valorLivro) {
        valorLivro.addEventListener('blur', function () {
            if (this.value) {
                this.value = Number(this.value.replace(',', '.')).toFixed(2);
            }
        });
    }

    if (form) {
        const inputCapa = document.getElementById('capaLivro');
        const previewCapa = document.getElementById('previewCapaLivro');

        if (inputCapa && previewCapa) {
            inputCapa.addEventListener('input', () => {
                const url = inputCapa.value.trim();

                if (url.length > 8) {
                    previewCapa.src = url;
                }
            });
        }
    }
}

function prepararBuscaInstantanea() {
    const campoBusca = document.getElementById('buscaInstantanea');

    if (!campoBusca) {
        return;
    }

    campoBusca.addEventListener('input', function () {
        const termo = this.value.toLowerCase().trim();

        document.querySelectorAll('.item-busca').forEach(item => {
            const texto = item.innerText.toLowerCase();

            if (texto.includes(termo)) {
                item.style.display = '';
                item.style.opacity = '1';
                item.style.transform = 'translateY(0px)';
            } else {
                item.style.opacity = '0';
                item.style.transform = 'translateY(10px)';

                setTimeout(() => {
                    item.style.display = 'none';
                }, 180);
            }
        });

        document.querySelectorAll('.item-busca').forEach(item => {
            const texto = item.innerText.toLowerCase();

            if (texto.includes(termo)) {
                setTimeout(() => {
                    item.style.display = '';
                }, 10);
            }
        });
    });
}

function prepararAnimacoesPremium() {

    const animatedItems = document.querySelectorAll(
        '.dashboard-card, .book-card, .hero-card, .table-card, .book-card-premium'
    );

    const observer = new IntersectionObserver(entries => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('fade-in-visible');
            }
        });
    }, {
        threshold: 0.08
    });

    animatedItems.forEach(item => {
        item.classList.add('fade-in-hidden');
        observer.observe(item);
    });

    document.querySelectorAll('.book-card, .dashboard-card').forEach(card => {

        card.addEventListener('mousemove', e => {
            const rect = card.getBoundingClientRect();

            const x = e.clientX - rect.left;
            const y = e.clientY - rect.top;

            const rotateY = ((x / rect.width) - 0.5) * 10;
            const rotateX = ((y / rect.height) - 0.5) * -10;

            card.style.transform = `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg) translateY(-6px)`;
        });

        card.addEventListener('mouseleave', () => {
            card.style.transform = '';
        });
    });
}

document.addEventListener('DOMContentLoaded', function () {
    prepararValidacaoUsuario();
    prepararValidacaoLivro();
    prepararBuscaInstantanea();
    prepararAnimacoesPremium();
});