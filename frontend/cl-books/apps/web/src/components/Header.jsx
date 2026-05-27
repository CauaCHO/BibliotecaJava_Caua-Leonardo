import React from 'react';
import { ShoppingCart } from 'lucide-react';

export default function Header({ onCartClick }) {
  return (
    <header className="navbar">
      <div className="logo">
        CL <span>Book's</span>
      </div>

      <nav className="nav-links">
        <a href="#home">Home</a>
        <a href="#catalogo">Catálogo</a>
        <a href="#dashboard">Dashboard</a>
      </nav>

      <div className="nav-actions">
        <button className="primary-btn">Explorar</button>

        <button className="icon-btn" onClick={onCartClick}>
          <ShoppingCart size={18} />
        </button>
      </div>
    </header>
  );
}
