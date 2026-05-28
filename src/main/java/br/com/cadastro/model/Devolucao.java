package br.com.cadastro.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public record Devolucao(
        Integer id,
        Integer emprestimoId,
        LocalDateTime dataDevolucao,
        BigDecimal multaDiasAtraso,
        String observacoes
) {
}
