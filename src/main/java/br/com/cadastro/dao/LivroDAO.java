package br.com.cadastro.dao;

import br.com.cadastro.model.Livro;
import br.com.cadastro.util.Conexao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
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
        String sql = "INSERT INTO livros (nome_livro, isbn, autor, capa_livro, data_publicacao, valor_livro, categoria_id) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

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

        String sql = "SELECT l.id, l.nome_livro, l.isbn, l.autor, l.capa_livro, l.data_publicacao, " +
                "l.valor_livro, l.categoria_id, c.nome_categoria " +
                "FROM livros l " +
                "LEFT JOIN categorias c ON c.id = l.categoria_id " +
                "ORDER BY l.id DESC";

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

    public List<Livro> pesquisar(String termo) {
        List<Livro> livros = new ArrayList<>();

        String sql = "SELECT l.id, l.nome_livro, l.isbn, l.autor, l.capa_livro, l.data_publicacao, " +
                "l.valor_livro, l.categoria_id, c.nome_categoria " +
                "FROM livros l " +
                "LEFT JOIN categorias c ON c.id = l.categoria_id " +
                "WHERE LOWER(l.nome_livro) LIKE LOWER(?) " +
                "OR LOWER(l.autor) LIKE LOWER(?) " +
                "OR LOWER(l.isbn) LIKE LOWER(?) " +
                "OR LOWER(COALESCE(c.nome_categoria, '')) LIKE LOWER(?) " +
                "ORDER BY l.id DESC";

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql)) {

            String busca = "%" + termo + "%";
            ps.setString(1, busca);
            ps.setString(2, busca);
            ps.setString(3, busca);
            ps.setString(4, busca);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    livros.add(mapearLivro(rs));
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao pesquisar livros: " + e.getMessage(), e);
        }

        return livros;
    }

    public Livro buscarPorId(int id) {
        String sql = "SELECT l.id, l.nome_livro, l.isbn, l.autor, l.capa_livro, l.data_publicacao, " +
                "l.valor_livro, l.categoria_id, c.nome_categoria " +
                "FROM livros l " +
                "LEFT JOIN categorias c ON c.id = l.categoria_id " +
                "WHERE l.id = ?";

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

    public long contar() {
        String sql = "SELECT COUNT(*) FROM livros";

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            return rs.next() ? rs.getLong(1) : 0;

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao contar livros: " + e.getMessage(), e);
        }
    }

    public void atualizar(Livro livro) {
        String sql = "UPDATE livros SET nome_livro = ?, isbn = ?, autor = ?, capa_livro = ?, " +
                "data_publicacao = ?, valor_livro = ?, categoria_id = ? WHERE id = ?";

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql)) {

            preencherStatement(ps, livro);
            ps.setInt(8, livro.getId());
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
        ps.setString(4, livro.getCapaLivro());
        ps.setDate(5, Date.valueOf(livro.getDataPublicacao()));
        ps.setBigDecimal(6, livro.getValorLivro());

        if (livro.getCategoriaId() == null) {
            ps.setNull(7, Types.INTEGER);
        } else {
            ps.setInt(7, livro.getCategoriaId());
        }
    }

    private Livro mapearLivro(ResultSet rs) throws SQLException {
        Livro livro = new Livro();
        livro.setId(rs.getInt("id"));
        livro.setNomeLivro(rs.getString("nome_livro"));
        livro.setIsbn(rs.getString("isbn"));
        livro.setAutor(rs.getString("autor"));
        livro.setCapaLivro(rs.getString("capa_livro"));
        livro.setDataPublicacao(rs.getDate("data_publicacao").toLocalDate());
        livro.setValorLivro(rs.getBigDecimal("valor_livro"));

        int categoriaId = rs.getInt("categoria_id");
        if (!rs.wasNull()) {
            livro.setCategoriaId(categoriaId);
        }

        livro.setNomeCategoria(rs.getString("nome_categoria"));
        return livro;
    }
}
