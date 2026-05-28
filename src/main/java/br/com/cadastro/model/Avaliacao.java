package br.com.cadastro.model;

import java.time.LocalDateTime;

public record Avaliacao(
        Integer id,
        Integer usuarioId,
        Integer livroId,
        Integer nota,
        String comentario,
        LocalDateTime dataAvaliacao
) {
}
