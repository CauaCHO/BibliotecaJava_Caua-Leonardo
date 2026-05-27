package br.com.cadastro.dao;

import br.com.cadastro.model.Categoria;
import br.com.cadastro.util.Conexao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoriaDAO {

    public void salvar(Categoria categoria) {
        if (categoria.getId() == null) {
            inserir(categoria);
        } else {
            atualizar(categoria);
        }
    }

    public void inserir(Categoria categoria) {
        String sql = "INSERT INTO categorias (nome_categoria, descricao) VALUES (?, ?)";

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql)) {

            ps.setString(1, categoria.getNomeCategoria());
            ps.setString(2, categoria.getDescricao());
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao inserir categoria: " + e.getMessage(), e);
        }
    }

    public void atualizar(Categoria categoria) {
        String sql = "UPDATE categorias SET nome_categoria = ?, descricao = ? WHERE id = ?";

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql)) {

            ps.setString(1, categoria.getNomeCategoria());
            ps.setString(2, categoria.getDescricao());
            ps.setInt(3, categoria.getId());
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao atualizar categoria: " + e.getMessage(), e);
        }
    }

    public List<Categoria> listarTodos() {
        List<Categoria> categorias = new ArrayList<>();

        String sql = "SELECT id, nome_categoria, descricao FROM categorias ORDER BY nome_categoria";

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                categorias.add(mapearCategoria(rs));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar categorias: " + e.getMessage(), e);
        }

        return categorias;
    }

    public Categoria buscarPorId(int id) {
        String sql = "SELECT id, nome_categoria, descricao FROM categorias WHERE id = ?";

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapearCategoria(rs);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar categoria: " + e.getMessage(), e);
        }

        return null;
    }

    public boolean nomeExiste(String nomeCategoria, Integer idIgnorado) {
        String sql = "SELECT COUNT(*) FROM categorias WHERE LOWER(nome_categoria) = LOWER(?)";

        if (idIgnorado != null) {
            sql += " AND id <> ?";
        }

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql)) {

            ps.setString(1, nomeCategoria);

            if (idIgnorado != null) {
                ps.setInt(2, idIgnorado);
            }

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao validar categoria duplicada: " + e.getMessage(), e);
        }
    }

    public long contar() {
        String sql = "SELECT COUNT(*) FROM categorias";

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            return rs.next() ? rs.getLong(1) : 0;

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao contar categorias: " + e.getMessage(), e);
        }
    }

    public void excluir(int id) {
        String sql = "DELETE FROM categorias WHERE id = ?";

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao excluir categoria. Verifique se existem livros vinculados a ela.", e);
        }
    }

    private Categoria mapearCategoria(ResultSet rs) throws SQLException {
        Categoria categoria = new Categoria();
        categoria.setId(rs.getInt("id"));
        categoria.setNomeCategoria(rs.getString("nome_categoria"));
        categoria.setDescricao(rs.getString("descricao"));
        return categoria;
    }
}
