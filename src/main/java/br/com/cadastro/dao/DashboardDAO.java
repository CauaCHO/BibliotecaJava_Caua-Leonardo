package br.com.cadastro.dao;

import br.com.cadastro.util.ConnectionFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

public class DashboardDAO {

    public Map<String, Integer> buscarMetricas() {
        Map<String, Integer> metricas = new HashMap<>();

        metricas.put("livros", contar("SELECT COUNT(*) FROM livros"));
        metricas.put("usuarios", contar("SELECT COUNT(*) FROM usuarios"));
        metricas.put("emprestimosAtivos", contar("SELECT COUNT(*) FROM emprestimos WHERE status = 'ATIVO'"));
        metricas.put("avaliacoes", contar("SELECT COUNT(*) FROM avaliacoes"));

        return metricas;
    }

    private Integer contar(String sql) {
        try (
                Connection connection = ConnectionFactory.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql);
                ResultSet resultSet = statement.executeQuery()
        ) {
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
}
