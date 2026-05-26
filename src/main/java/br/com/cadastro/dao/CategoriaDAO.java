package br.com.cadastro.dao;

import br.com.cadastro.model.Categoria;
import br.com.cadastro.util.Conexao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoriaDAO {

    public List<Categoria> listarTodos() {
        List<Categoria> categorias = new ArrayList<>();

        String sql = "SELECT * FROM categorias ORDER BY nome_categoria";

        try (Connection conn = Conexao.getConexao();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Categoria categoria = new Categoria();

                categoria.setId(rs.getInt("id"));
                categoria.setNomeCategoria(rs.getString("nome_categoria"));
                categoria.setDescricao(rs.getString("descricao"));

                categorias.add(categoria);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar categorias: " + e.getMessage());
        }

        return categorias;
    }
}
