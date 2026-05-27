import React, { useEffect, useMemo, useState } from 'react';
import { Search } from 'lucide-react';
import { getCategories, getProducts } from '@/api/EcommerceApi.js';
import { useCart } from '@/hooks/useCart.jsx';

export default function ProductsGrid() {
  const { addItem } = useCart();
  const [products, setProducts] = useState([]);
  const [categories, setCategories] = useState([]);
  const [search, setSearch] = useState('');
  const [category, setCategory] = useState('all');
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function load() {
      try {
        const [productsData, categoriesData] = await Promise.all([
          getProducts(),
          getCategories()
        ]);

        setProducts(productsData.products || []);
        setCategories(categoriesData || []);
      } finally {
        setLoading(false);
      }
    }

    load();
  }, []);

  const filtered = useMemo(() => {
    return products.filter((product) => {
      const text = `${product.title} ${product.subtitle}`.toLowerCase();
      const matchSearch = text.includes(search.toLowerCase());
      const matchCategory = category === 'all' || product.category === category;

      return matchSearch && matchCategory;
    });
  }, [products, search, category]);

  return (
    <section className="section" id="catalogo">
      <div className="section-head">
        <div>
          <h2>Catálogo cinematográfico</h2>
          <p className="muted">Livros reais vindos diretamente do PostgreSQL.</p>
        </div>
      </div>

      <div className="catalog-tools">
        <div style={{ position: 'relative' }}>
          <Search size={18} style={{ position: 'absolute', left: 14, top: 15, color: '#94A3B8' }} />
          <input
            className="search"
            style={{ paddingLeft: 44 }}
            placeholder="Buscar livros..."
            value={search}
            onChange={(e) => setSearch(e.target.value)}
          />
        </div>

        <select className="select" value={category} onChange={(e) => setCategory(e.target.value)}>
          <option value="all">Todas categorias</option>
          {categories.map((item) => (
            <option key={item.id} value={item.name}>{item.name}</option>
          ))}
        </select>
      </div>

      {loading ? (
        <p className="muted">Carregando catálogo...</p>
      ) : (
        <div className="product-grid">
          {filtered.map((product) => (
            <article className="product-card" key={product.id}>
              <img src={product.image} alt={product.title} />

              <div className="product-info">
                <span className="badge">{product.category}</span>
                <h3>{product.title}</h3>
                <p className="muted">{product.subtitle}</p>
                <div className="price">{product.variants?.[0]?.price_formatted}</div>
                <button className="add-btn" onClick={() => addItem(product)}>Adicionar ao carrinho</button>
              </div>
            </article>
          ))}
        </div>
      )}
    </section>
  );
}
