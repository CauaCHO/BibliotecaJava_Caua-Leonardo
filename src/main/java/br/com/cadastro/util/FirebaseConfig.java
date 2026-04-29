package br.com.cadastro.util;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.firestore.Firestore;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.cloud.FirestoreClient;

import java.io.InputStream;

public class FirebaseConfig {

    private static Firestore firestore;

    public static synchronized Firestore getFirestore() {
        if (firestore != null) {
            return firestore;
        }

        try {
            if (FirebaseApp.getApps().isEmpty()) {
                try (InputStream serviceAccount = FirebaseConfig.class
                        .getClassLoader()
                        .getResourceAsStream("firebase-key.json")) {

                    if (serviceAccount == null) {
                        throw new RuntimeException(
                                "Arquivo firebase-key.json não encontrado. Coloque ele em src/main/resources/firebase-key.json"
                        );
                    }

                    FirebaseOptions options = FirebaseOptions.builder()
                            .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                            .build();

                    FirebaseApp.initializeApp(options);
                }
            }

            firestore = FirestoreClient.getFirestore();
            System.out.println("Firebase conectado com sucesso!");
            return firestore;

        } catch (Exception e) {
            throw new RuntimeException("Erro ao inicializar Firebase: " + e.getMessage(), e);
        }
    }
}
