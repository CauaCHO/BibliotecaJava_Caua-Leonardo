// app.js - Scripts do Sistema de Gestão de Biblioteca
// Arquivo baseado na proposta das aulas: máscaras, validações e comportamentos no frontend.

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
                alert('CPF/CNPJ inválido. Informe ao menos 11 números.');
                cpfCnpj.focus();
                return;
            }

            if (email && !validarEmailFormato(email.value)) {
                event.preventDefault();
                alert('E-mail inválido. Verifique o formato informado.');
                email.focus();
                return;
            }
        });
    }
}

function prepararValidacaoLivro() {
    const email = document.getElementById('email');
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
        form.addEventListener('submit', function (event) {
            if (email && !validarEmailFormato(email.value)) {
                event.preventDefault();
                alert('E-mail inválido. Verifique o formato informado.');
                email.focus();
            }
        });
    }
}

function prepararBuscaInstantanea() {
    const campoBusca = document.getElementById('buscaInstantanea');
    const tabela = document.getElementById('tabelaDados');

    if (!campoBusca || !tabela) {
        return;
    }

    campoBusca.addEventListener('input', function () {
        const termo = this.value.toLowerCase().trim();
        const linhas = tabela.querySelectorAll('tbody tr');

        linhas.forEach(linha => {
            const textoLinha = linha.innerText.toLowerCase();
            linha.style.display = textoLinha.includes(termo) ? '' : 'none';
        });
    });
}

document.addEventListener('DOMContentLoaded', function () {
    prepararValidacaoUsuario();
    prepararValidacaoLivro();
    prepararBuscaInstantanea();
});
