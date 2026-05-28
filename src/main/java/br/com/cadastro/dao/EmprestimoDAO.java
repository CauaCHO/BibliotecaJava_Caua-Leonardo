package br.com.cadastro.dao;

import br.com.cadastro.model.Emprestimo;
import br.com.cadastro.util.Conexao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;

public class EmprestimoDAO {

    public void cadastrar(Emprestimo emprestimo) {
        String sql = """
                INSERT INTO emprestimos (
                    usuario_id,
                    livro_id,
                    data_devolucao_prevista,
                    status,
                    renovacoes_restantes
                ) VALUES (?, ?, ?, ?, ?)
                """;

        try (
                Connection connection = Conexao.getConexao();
                PreparedStatement statement = connection.prepareStatement(sql)
        ) {
            statement.setInt(1, emprestimo.getUsuarioId());
            statement.setInt(2, emprestimo.getLivroId());
            statement.setDate(3, java.sql.Date.valueOf(emprestimo.getDataDevolucaoPrevista()));
            statement.setString(4, emprestimo.getStatus());
            statement.setInt(5, emprestimo.getRenovacoesRestantes());

            statement.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Emprestimo> listar() {
        return List.of();
    }
}
