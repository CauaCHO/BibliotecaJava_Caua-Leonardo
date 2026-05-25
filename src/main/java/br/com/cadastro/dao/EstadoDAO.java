package br.com.cadastro.dao;

import br.com.cadastro.model.Estado;
import br.com.cadastro.util.Conexao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EstadoDAO {

    public void salvar(Estado estado) {
        if (estado.getId() == null) {
            inserir(estado);
        } else {
            atualizar(estado);
        }
    }

    public void inserir(Estado estado) {
        String sql = "INSERT INTO estados (nome_estado, sigla_estado) VALUES (?, ?)";

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql)) {

            ps.setString(1, estado.getNomeEstado());
            ps.setString(2, estado.getSiglaEstado().toUpperCase());
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao inserir estado: " + e.getMessage(), e);
        }
    }

    public List<Estado> listarTodos() {
        List<Estado> estados = new ArrayList<>();
        String sql = "SELECT id, nome_estado, sigla_estado FROM estados ORDER BY nome_estado";

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                estados.add(mapearEstado(rs));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar estados: " + e.getMessage(), e);
        }

        return estados;
    }

    public Estado buscarPorId(int id) {
        String sql = "SELECT id, nome_estado, sigla_estado FROM estados WHERE id = ?";

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapearEstado(rs);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar estado: " + e.getMessage(), e);
        }

        return null;
    }

    public boolean siglaExiste(String sigla, Integer idIgnorado) {
        String sql = "SELECT COUNT(*) FROM estados WHERE UPPER(sigla_estado) = UPPER(?)";

        if (idIgnorado != null) {
            sql += " AND id <> ?";
        }

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql)) {

            ps.setString(1, sigla);

            if (idIgnorado != null) {
                ps.setInt(2, idIgnorado);
            }

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao validar sigla duplicada: " + e.getMessage(), e);
        }
    }

    public long contar() {
        String sql = "SELECT COUNT(*) FROM estados";

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            return rs.next() ? rs.getLong(1) : 0;

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao contar estados: " + e.getMessage(), e);
        }
    }

    public void atualizar(Estado estado) {
        String sql = "UPDATE estados SET nome_estado = ?, sigla_estado = ? WHERE id = ?";

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql)) {

            ps.setString(1, estado.getNomeEstado());
            ps.setString(2, estado.getSiglaEstado().toUpperCase());
            ps.setInt(3, estado.getId());
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao atualizar estado: " + e.getMessage(), e);
        }
    }

    public void excluir(int id) {
        String sql = "DELETE FROM estados WHERE id = ?";

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao excluir estado: " + e.getMessage(), e);
        }
    }

    private Estado mapearEstado(ResultSet rs) throws SQLException {
        Estado estado = new Estado();
        estado.setId(rs.getInt("id"));
        estado.setNomeEstado(rs.getString("nome_estado"));
        estado.setSiglaEstado(rs.getString("sigla_estado"));
        return estado;
    }
}
