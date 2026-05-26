package br.com.cadastro.dao;

import br.com.cadastro.model.Usuario;
import br.com.cadastro.util.Conexao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    public void salvar(Usuario usuario) {
        if (usuario.getId() == null) {
            inserir(usuario);
        } else {
            atualizar(usuario);
        }
    }

    private void inserir(Usuario usuario) {
        String sql = "INSERT INTO usuarios (nome_usuario, cpf_cnpj, email, estado_id) VALUES (?, ?, ?, ?)";

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql)) {

            preencherStatement(ps, usuario);
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao inserir usuário: " + e.getMessage(), e);
        }
    }

    private void atualizar(Usuario usuario) {
        String sql = "UPDATE usuarios SET nome_usuario = ?, cpf_cnpj = ?, email = ?, estado_id = ? WHERE id = ?";

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql)) {

            preencherStatement(ps, usuario);
            ps.setInt(5, usuario.getId());
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao atualizar usuário: " + e.getMessage(), e);
        }
    }

    public List<Usuario> listarTodos() {
        List<Usuario> usuarios = new ArrayList<>();

        String sql = "SELECT u.id, u.nome_usuario, u.cpf_cnpj, u.email, u.estado_id, " +
                "e.nome_estado, e.sigla_estado " +
                "FROM usuarios u " +
                "LEFT JOIN estados e ON e.id = u.estado_id " +
                "ORDER BY u.nome_usuario";

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                usuarios.add(mapearUsuario(rs));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar usuários: " + e.getMessage(), e);
        }

        return usuarios;
    }

    public Usuario buscarPorId(int id) {
        String sql = "SELECT u.id, u.nome_usuario, u.cpf_cnpj, u.email, u.estado_id, " +
                "e.nome_estado, e.sigla_estado " +
                "FROM usuarios u " +
                "LEFT JOIN estados e ON e.id = u.estado_id " +
                "WHERE u.id = ?";

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapearUsuario(rs);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao buscar usuário: " + e.getMessage(), e);
        }

        return null;
    }

    public void excluir(int id) {
        String sql = "DELETE FROM usuarios WHERE id = ?";

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao excluir usuário: " + e.getMessage(), e);
        }
    }

    public boolean emailExiste(String email, Integer idIgnorado) {
        String sql = "SELECT COUNT(*) FROM usuarios WHERE LOWER(email) = LOWER(?)";

        if (idIgnorado != null) {
            sql += " AND id <> ?";
        }

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql)) {

            ps.setString(1, email);

            if (idIgnorado != null) {
                ps.setInt(2, idIgnorado);
            }

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao validar e-mail: " + e.getMessage(), e);
        }
    }

    public boolean cpfExiste(String cpf, Integer idIgnorado) {
        String sql = "SELECT COUNT(*) FROM usuarios WHERE cpf_cnpj = ?";

        if (idIgnorado != null) {
            sql += " AND id <> ?";
        }

        try (Connection conexao = Conexao.getConexao();
             PreparedStatement ps = conexao.prepareStatement(sql)) {

            ps.setString(1, cpf);

            if (idIgnorado != null) {
                ps.setInt(2, idIgnorado);
            }

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao validar CPF/CNPJ: " + e.getMessage(), e);
        }
    }

    private void preencherStatement(PreparedStatement ps, Usuario usuario) throws SQLException {
        ps.setString(1, usuario.getNomeUsuario());
        ps.setString(2, usuario.getCpfCnpj());
        ps.setString(3, usuario.getEmail());

        if (usuario.getEstadoId() == null) {
            ps.setNull(4, Types.INTEGER);
        } else {
            ps.setInt(4, usuario.getEstadoId());
        }
    }

    private Usuario mapearUsuario(ResultSet rs) throws SQLException {
        Usuario usuario = new Usuario();

        usuario.setId(rs.getInt("id"));
        usuario.setNomeUsuario(rs.getString("nome_usuario"));
        usuario.setCpfCnpj(rs.getString("cpf_cnpj"));
        usuario.setEmail(rs.getString("email"));

        int estadoId = rs.getInt("estado_id");
        if (!rs.wasNull()) {
            usuario.setEstadoId(estadoId);
        }

        usuario.setNomeEstado(rs.getString("nome_estado"));
        usuario.setSiglaEstado(rs.getString("sigla_estado"));

        return usuario;
    }
}
