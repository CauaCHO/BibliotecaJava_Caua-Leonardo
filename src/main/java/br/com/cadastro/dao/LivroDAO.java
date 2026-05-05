package br.com.cadastro.dao;

import br.com.cadastro.model.Livro;
import br.com.cadastro.util.Conexao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class LivroDAO {

    public void salvar(Livro livro) {
        if (livro.getId() == null) {
            inserir(livro);
        } else {
            atualizar(livro);
        }
    }

    public void inserir(Livro livro) {
        String sql = "INSERT INTO livros (nome_livro, isbn, autor, data_publicacao, valor_livro) VALUES (?, ?, ?, ?, ?)";

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql)) {

            preencherStatement(ps, livro);
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao inserir livro: " + e.getMessage(), e);
        }
    }

    public List<Livro> listarTodos() {
        List<Livro> livros = new ArrayList<>();
        String sql = "SELECT id, nome_livro, isbn, autor, data_publicacao, valor_livro FROM livros ORDER BY id DESC";

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                livros.add(mapearLivro(rs));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar livros: " + e.getMessage(), e);
        }

        return livros;
    }

    public Livro buscarPorId(int id) {
        String sql = "SELECT id, nome_livro, isbn, autor, data_publicacao, valor_livro FROM livros WHERE id = ?";

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapearLivro(rs);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar livro: " + e.getMessage(), e);
        }

        return null;
    }

    public void atualizar(Livro livro) {
        String sql = "UPDATE livros SET nome_livro = ?, isbn = ?, autor = ?, data_publicacao = ?, valor_livro = ? WHERE id = ?";

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql)) {

            preencherStatement(ps, livro);
            ps.setInt(6, livro.getId());
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao atualizar livro: " + e.getMessage(), e);
        }
    }

    public void excluir(int id) {
        String sql = "DELETE FROM livros WHERE id = ?";

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao excluir livro: " + e.getMessage(), e);
        }
    }

    private void preencherStatement(PreparedStatement ps, Livro livro) throws SQLException {
        ps.setString(1, livro.getNomeLivro());
        ps.setString(2, livro.getIsbn());
        ps.setString(3, livro.getAutor());
        ps.setDate(4, Date.valueOf(livro.getDataPublicacao()));
        ps.setBigDecimal(5, livro.getValorLivro());
    }

    private Livro mapearLivro(ResultSet rs) throws SQLException {
        Livro livro = new Livro();
        livro.setId(rs.getInt("id"));
        livro.setNomeLivro(rs.getString("nome_livro"));
        livro.setIsbn(rs.getString("isbn"));
        livro.setAutor(rs.getString("autor"));
        livro.setDataPublicacao(rs.getDate("data_publicacao").toLocalDate());
        livro.setValorLivro(rs.getBigDecimal("valor_livro"));
        return livro;
    }
}
