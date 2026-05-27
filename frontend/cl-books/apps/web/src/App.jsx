import React, { useEffect, useMemo, useState } from 'react';
import { getCategories, getProducts, getStates } from './api/EcommerceApi';

export default function App() {
  const [products, setProducts] = useState([]);
  const [categories, setCategories] = useState([]);
  const [states, setStates] = useState([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState('');
  const [category, setCategory] = useState('all');
  const [cartOpen, setCartOpen] = useState(false);
  const [cart, setCart] = useState([]);

  useEffect(() => {
    async function load() {
      try {
        const [productsData, categoriesData, statesData] = await Promise.all([
          getProducts(),
          getCategories(),
          getStates()
        ]);

        setProducts(productsData.products || []);
        setCategories(categoriesData || []);
        setStates(statesData || []);
      } finally {
        setLoading(false);
      }
    }

    load();
  }, []);

  const filteredProducts = useMemo(() => {
    return products.filter((product) => {
      const matchesSearch = product.title.toLowerCase().includes(search.toLowerCase()) || product.subtitle.toLowerCase().includes(search.toLowerCase());
      const matchesCategory = category === 'all' || product.category === category;

      return matchesSearch && matchesCategory;
    });
  }, [products, search, category]);

  function addToCart(product) {
    setCart((prev) => [...prev, product]);
    setCartOpen(true);
  }

  const total = cart.reduce((sum, item) => sum + (item.variants?.[0]?.price_in_cents || 0), 0) / 100;

  return (
    <div className="app-shell">
      <nav className="navbar">
        <div className="logo">CL <span>Book's</span></div>

        <div className="nav-links">
          <a href="#home">Home</a>
          <a href="#catalogo">Catálogo</a>
          <a href="#dashboard">Dashboard</a>
          <a href="#sobre">Sobre</a>
        </div>

        <div className="nav-actions">
          <button className="icon-btn">🔎</button>
          <button className="icon-btn" onClick={() => setCartOpen(true)}>🛒</button>
        </div>
      </nav>

      <section className="hero" id="home">
        <div>
          <div className="eyebrow">Plataforma literária premium</div>
          <h1>
            O próximo livro que <span className="gradient-text">muda sua vida</span> está aqui.
          </h1>

          <p>
            Explore um catálogo cinematográfico com experiência moderna, dashboard premium e integração completa com Java + PostgreSQL.
          </p>

          <div className="hero-actions">
            <button className="primary-btn">Explorar Catálogo</button>
            <button className="secondary-btn">Acessar Dashboard</button>
          </div>

          <div className="benefits">
            <span>{products.length}+ livros</span>
            <span>{categories.length} categorias</span>
            <span>{states.length} estados</span>
            <span>Compra segura</span>
          </div>
        </div>

        <div className="floating-books">
          <img className="book-float book-a" src="https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=500" />
          <img className="book-float book-b" src="https://images.unsplash.com/photo-1512820790803-83ca734da794?w=500" />
          <img className="book-float book-c" src="https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=500" />
        </div>
      </section>

      <section className="section">
        <div className="section-head">
          <div>
            <h2>Funcionalidades premium</h2>
            <p className="muted">Frontend cinematográfico conectado ao backend Java real.</p>
          </div>
        </div>

        <div className="features">
          <div className="feature-card">
            <h3>📚 Catálogo Inteligente</h3>
            <p className="muted">Catálogo Netflix-style com busca instantânea e categorias reais.</p>
          </div>

          <div className="feature-card">
            <h3>⚙️ Gestão Completa</h3>
            <p className="muted">Integração Java + PostgreSQL com APIs reais e dashboard premium.</p>
          </div>

          <div className="feature-card">
            <h3>🛒 Compra Simplificada</h3>
            <p className="muted">Carrinho slide-in moderno preparado para checkout.</p>
          </div>
        </div>
      </section>

      <section className="section" id="catalogo">
        <div className="section-head">
          <div>
            <h2>Catálogo cinematográfico</h2>
            <p className="muted">Livros reais vindos diretamente do PostgreSQL.</p>
          </div>
        </div>

        <div className="catalog-tools">
          <input className="search" placeholder="Buscar livros..." value={search} onChange={(e) => setSearch(e.target.value)} />

          <select className="select" value={category} onChange={(e) => setCategory(e.target.value)}>
            <option value="all">Todas categorias</option>
            {categories.map((cat) => (
              <option key={cat.id} value={cat.name}>{cat.name}</option>
            ))}
          </select>
        </div>

        {loading ? (
          <p className="muted">Carregando catálogo...</p>
        ) : (
          <div className="product-grid">
            {filteredProducts.map((product) => (
              <div className="product-card" key={product.id}>
                <img src={product.image} alt={product.title} />

                <div className="product-info">
                  <span className="badge">{product.category}</span>
                  <h3>{product.title}</h3>
                  <p className="muted">{product.subtitle}</p>
                  <div className="price">{product.variants?.[0]?.price_formatted}</div>
                  <button className="add-btn" onClick={() => addToCart(product)}>Adicionar ao Carrinho</button>
                </div>
              </div>
            ))}
          </div>
        )}
      </section>

      <section className="section" id="dashboard">
        <div className="section-head">
          <div>
            <h2>Dashboard premium</h2>
            <p className="muted">Métricas integradas ao backend Java.</p>
          </div>
        </div>

        <div className="dashboard-grid">
          <div className="dashboard-card">
            <span className="muted">Livros</span>
            <strong>{products.length}</strong>
          </div>

          <div className="dashboard-card">
            <span className="muted">Categorias</span>
            <strong>{categories.length}</strong>
          </div>

          <div className="dashboard-card">
            <span className="muted">Estados</span>
            <strong>{states.length}</strong>
          </div>

          <div className="dashboard-card">
            <span className="muted">Carrinho</span>
            <strong>{cart.length}</strong>
          </div>
        </div>

        <div className="admin-panel">
          <table className="table">
            <thead>
              <tr>
                <th>Livro</th>
                <th>Autor</th>
                <th>Categoria</th>
                <th>Preço</th>
              </tr>
            </thead>

            <tbody>
              {products.slice(0, 6).map((product) => (
                <tr key={product.id}>
                  <td>{product.title}</td>
                  <td>{product.subtitle}</td>
                  <td>{product.category}</td>
                  <td>{product.variants?.[0]?.price_formatted}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </section>

      <footer className="footer" id="sobre">
        CL Book's © Plataforma híbrida React + Java + PostgreSQL.
      </footer>

      {cartOpen && (
        <div className="cart-overlay" onClick={() => setCartOpen(false)}>
          <div className="cart-panel" onClick={(e) => e.stopPropagation()}>
            <h2>Seu carrinho</h2>

            {cart.length === 0 ? (
              <p className="muted">Nenhum livro adicionado.</p>
            ) : (
              <>
                {cart.map((item, index) => (
                  <div className="cart-item" key={`${item.id}-${index}`}>
                    <img src={item.image} alt={item.title} />
                    <div>
                      <strong>{item.title}</strong>
                      <div className="muted">{item.subtitle}</div>
                    </div>
                    <strong>{item.variants?.[0]?.price_formatted}</strong>
                  </div>
                ))}

                <hr style={{ borderColor: 'rgba(255,255,255,.08)' }} />
                <h3>Total: R$ {total.toFixed(2)}</h3>
                <button className="primary-btn" style={{ width: '100%' }}>Finalizar Compra</button>
              </>
            )}
          </div>
        </div>
      )}
    </div>
  );
}
