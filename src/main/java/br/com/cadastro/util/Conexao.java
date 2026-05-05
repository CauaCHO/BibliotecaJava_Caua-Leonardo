package br.com.cadastro.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexao {

    private static final String URL_PADRAO = "jdbc:postgresql://localhost:5432/biblioteca_java";
    private static final String USUARIO_PADRAO = "postgres";
    private static final String SENHA_PADRAO = "postgres";

    private Conexao() {
    }

    public static Connection getConexao() throws SQLException {
        String url = System.getenv().getOrDefault("DB_URL", URL_PADRAO);
        String usuario = System.getenv().getOrDefault("DB_USER", USUARIO_PADRAO);
        String senha = System.getenv().getOrDefault("DB_PASSWORD", SENHA_PADRAO);

        return DriverManager.getConnection(url, usuario, senha);
    }
}
