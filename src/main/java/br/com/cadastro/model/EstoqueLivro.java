package br.com.cadastro.model;

import java.time.LocalDateTime;

public record EstoqueLivro(
        Integer id,
        Integer livroId,
        Integer quantidadeTotal,
        Integer quantidadeDisponivel,
        LocalDateTime dataAtualizacao
) {
}
