import React, { useState } from 'react';
import { Helmet } from 'react-helmet';
import Header from '@/components/Header.jsx';
import ShoppingCart from '@/components/ShoppingCart.jsx';
import ProductsGrid from '@/components/ProductsGrid.jsx';

export default function HomePage() {
  const [cartOpen, setCartOpen] = useState(false);

  return (
    <div className="app-shell">
      <Helmet>
        <title>CL Book's | Plataforma Literária Premium</title>
      </Helmet>

      <Header onCartClick={() => setCartOpen(true)} />

      <section className="hero" id="home">
        <div>
          <div className="eyebrow">Plataforma literária premium</div>

          <h1>
            O próximo livro que <span className="gradient-text">muda sua vida</span> está aqui.
          </h1>

          <p>
            Uma experiência cinematográfica moderna integrada com React, Java e PostgreSQL.
          </p>

          <div className="hero-actions">
            <button className="primary-btn">Explorar catálogo</button>
            <button className="secondary-btn">Acessar dashboard</button>
          </div>

          <div className="benefits">
            <span>+10.000 obras</span>
            <span>Curadoria premium</span>
            <span>Compra segura</span>
            <span>Entrega rápida</span>
          </div>
        </div>

        <div className="floating-books">
          <img className="book-float book-a" src="https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=600" />
          <img className="book-float book-b" src="https://images.unsplash.com/photo-1512820790803-83ca734da794?w=600" />
          <img className="book-float book-c" src="https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=600" />
        </div>
      </section>

      <section className="section">
        <div className="features">
          <div className="feature-card">
            <h3>📚 Catálogo Inteligente</h3>
            <p className="muted">Busca instantânea, filtros modernos e visual Netflix-style.</p>
          </div>

          <div className="feature-card">
            <h3>⚙️ Gestão Completa</h3>
            <p className="muted">Backend Java real integrado ao PostgreSQL.</p>
          </div>

          <div className="feature-card">
            <h3>🛒 Compra Simplificada</h3>
            <p className="muted">Carrinho slide-in premium pronto para checkout.</p>
          </div>
        </div>
      </section>

      <ProductsGrid />

      <footer className="footer">
        CL Book's © React + Java + PostgreSQL.
      </footer>

      <ShoppingCart open={cartOpen} onClose={() => setCartOpen(false)} />
    </div>
  );
}
