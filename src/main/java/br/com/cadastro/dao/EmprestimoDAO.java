package br.com.cadastro.dao;

import br.com.cadastro.model.Emprestimo;
import br.com.cadastro.util.Conexao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao cadastrar empréstimo: " + e.getMessage(), e);
        }
    }

    public List<Emprestimo> listar() {
        List<Emprestimo> emprestimos = new ArrayList<>();

        String sql = """
                SELECT e.id,
                       e.usuario_id,
                       e.livro_id,
                       e.data_emprestimo,
                       e.data_devolucao_prevista,
                       e.data_devolucao_efetiva,
                       e.status,
                       e.renovacoes_restantes,
                       u.nome_usuario,
                       l.nome_livro
                FROM emprestimos e
                INNER JOIN usuarios u ON u.id = e.usuario_id
                INNER JOIN livros l ON l.id = e.livro_id
                ORDER BY e.id DESC
                """;

        try (
                Connection connection = Conexao.getConexao();
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet rs = statement.executeQuery()
        ) {
            while (rs.next()) {
                Emprestimo emprestimo = new Emprestimo();
                emprestimo.setId(rs.getInt("id"));
                emprestimo.setUsuarioId(rs.getInt("usuario_id"));
                emprestimo.setLivroId(rs.getInt("livro_id"));
                emprestimo.setDataEmprestimo(rs.getTimestamp("data_emprestimo").toLocalDateTime());
                emprestimo.setDataDevolucaoPrevista(rs.getDate("data_devolucao_prevista").toLocalDate());

                if (rs.getDate("data_devolucao_efetiva") != null) {
                    emprestimo.setDataDevolucaoEfetiva(rs.getDate("data_devolucao_efetiva").toLocalDate());
                }

                emprestimo.setStatus(rs.getString("status"));
                emprestimo.setRenovacoesRestantes(rs.getInt("renovacoes_restantes"));
                emprestimo.setNomeUsuario(rs.getString("nome_usuario"));
                emprestimo.setNomeLivro(rs.getString("nome_livro"));

                emprestimos.add(emprestimo);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar empréstimos: " + e.getMessage(), e);
        }

        return emprestimos;
    }
}
