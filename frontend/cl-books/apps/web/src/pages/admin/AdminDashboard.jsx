import React, { useEffect, useState } from 'react';
import { BarChart3, BookOpen, MapPin, ShoppingCart, Tags } from 'lucide-react';
import { getCategories, getProducts, getStates } from '@/api/EcommerceApi.js';

export default function AdminDashboard() {
  const [products, setProducts] = useState([]);
  const [categories, setCategories] = useState([]);
  const [states, setStates] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function loadDashboard() {
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

    loadDashboard();
  }, []);

  return (
    <main className="app-shell">
      <header className="navbar">
        <div className="logo">CL <span>Book's</span> Admin</div>

        <nav className="nav-links">
          <a href="/">Home</a>
          <a href="#metricas">Métricas</a>
          <a href="#livros">Livros</a>
        </nav>
      </header>

      <section className="section" id="metricas">
        <div className="section-head">
          <div>
            <div className="eyebrow">Painel Administrativo</div>
            <h2>Dashboard premium</h2>
            <p className="muted">Métricas em tempo real vindas do backend Java + PostgreSQL.</p>
          </div>
        </div>

        {loading ? (
          <p className="muted">Carregando dashboard...</p>
        ) : (
          <div className="dashboard-grid">
            <MetricCard icon={<BookOpen />} label="Livros" value={products.length} />
            <MetricCard icon={<Tags />} label="Categorias" value={categories.length} />
            <MetricCard icon={<MapPin />} label="Estados" value={states.length} />
            <MetricCard icon={<ShoppingCart />} label="Pedidos" value="0" />
          </div>
        )}

        <div className="admin-panel">
          <div className="section-head">
            <div>
              <h2 style={{ fontSize: '2rem' }}>Visão geral</h2>
              <p className="muted">Resumo visual do catálogo conectado ao banco.</p>
            </div>
            <BarChart3 color="#F59E0B" size={34} />
          </div>

          <div style={{ display: 'grid', gap: 12 }}>
            {categories.map((category) => {
              const total = products.filter((product) => product.category === category.name).length;
              const width = products.length ? Math.max(8, (total / products.length) * 100) : 8;

              return (
                <div key={category.id}>
                  <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 8 }}>
                    <strong>{category.name}</strong>
                    <span className="muted">{total} livros</span>
                  </div>
                  <div style={{ height: 10, borderRadius: 999, background: 'rgba(255,255,255,.08)', overflow: 'hidden' }}>
                    <div style={{ width: `${width}%`, height: '100%', background: 'linear-gradient(90deg, #F59E0B, #8B5CF6)' }} />
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      </section>

      <section className="section" id="livros">
        <div className="section-head">
          <div>
            <h2>Livros cadastrados</h2>
            <p className="muted">Tabela premium com dados reais da API Java.</p>
          </div>
        </div>

        <div className="admin-panel">
          <table className="table">
            <thead>
              <tr>
                <th>Livro</th>
                <th>Autor</th>
                <th>Categoria</th>
                <th>Valor</th>
              </tr>
            </thead>
            <tbody>
              {products.map((product) => (
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
    </main>
  );
}

function MetricCard({ icon, label, value }) {
  return (
    <div className="dashboard-card">
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <span className="muted">{label}</span>
        <span style={{ color: '#F59E0B' }}>{icon}</span>
      </div>
      <strong>{value}</strong>
    </div>
  );
}
