package br.com.cadastro.dao;

import br.com.cadastro.model.Livro;
import br.com.cadastro.util.FirebaseConfig;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.*;

import java.math.BigDecimal;
import java.util.*;

public class LivroDAO {
    private final Firestore db = FirebaseConfig.getFirestore();
    private final CollectionReference livros = db.collection("livros");

    public void inserir(Livro livro) throws Exception {
        Map<String, Object> dados = livroParaMap(livro);
        livros.add(dados).get();
    }

    public List<Livro> listar() throws Exception {
        ApiFuture<QuerySnapshot> future = livros.orderBy("nomeLivro").get();
        List<QueryDocumentSnapshot> documentos = future.get().getDocuments();
        List<Livro> lista = new ArrayList<>();

        for (QueryDocumentSnapshot doc : documentos) {
            lista.add(documentoParaLivro(doc));
        }
        return lista;
    }

    public Livro buscarPorId(String id) throws Exception {
        DocumentSnapshot doc = livros.document(id).get().get();
        if (!doc.exists()) {
            return null;
        }
        return documentoParaLivro(doc);
    }

    public void atualizar(Livro livro) throws Exception {
        livros.document(livro.getId()).set(livroParaMap(livro)).get();
    }

    public void excluir(String id) throws Exception {
        livros.document(id).delete().get();
    }

    private Map<String, Object> livroParaMap(Livro livro) {
        Map<String, Object> dados = new HashMap<>();
        dados.put("nomeLivro", livro.getNomeLivro());
        dados.put("isbn", livro.getIsbn());
        dados.put("autor", livro.getAutor());
        dados.put("dataPublicacao", livro.getDataPublicacao());
        dados.put("valorLivro", livro.getValorLivro() != null ? livro.getValorLivro().doubleValue() : 0.0);
        return dados;
    }

    private Livro documentoParaLivro(DocumentSnapshot doc) {
        Livro livro = new Livro();
        livro.setId(doc.getId());
        livro.setNomeLivro(doc.getString("nomeLivro"));
        livro.setIsbn(doc.getString("isbn"));
        livro.setAutor(doc.getString("autor"));
        livro.setDataPublicacao(doc.getString("dataPublicacao"));

        Object valor = doc.get("valorLivro");
        if (valor instanceof Number) {
            livro.setValorLivro(BigDecimal.valueOf(((Number) valor).doubleValue()));
        } else {
            livro.setValorLivro(BigDecimal.ZERO);
        }
        return livro;
    }
}
