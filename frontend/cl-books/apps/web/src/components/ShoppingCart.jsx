import React from 'react';
import { X } from 'lucide-react';
import { useCart } from '@/hooks/useCart.jsx';

export default function ShoppingCart({ open, onClose }) {
  const { items, total, removeItem } = useCart();

  if (!open) return null;

  return (
    <div className="cart-overlay" onClick={onClose}>
      <div className="cart-panel" onClick={(e) => e.stopPropagation()}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <h2>Seu carrinho</h2>

          <button className="icon-btn" onClick={onClose}>
            <X size={18} />
          </button>
        </div>

        {items.length === 0 ? (
          <p className="muted">Nenhum item adicionado.</p>
        ) : (
          <>
            {items.map((item, index) => (
              <div className="cart-item" key={`${item.id}-${index}`}>
                <img src={item.image} alt={item.title} />

                <div>
                  <strong>{item.title}</strong>
                  <div className="muted">{item.subtitle}</div>
                </div>

                <button className="icon-btn" onClick={() => removeItem(index)}>
                  <X size={14} />
                </button>
              </div>
            ))}

            <hr style={{ borderColor: 'rgba(255,255,255,.08)' }} />

            <h3>Total: R$ {(total / 100).toFixed(2)}</h3>

            <button className="primary-btn" style={{ width: '100%' }}>
              Finalizar Compra
            </button>
          </>
        )}
      </div>
    </div>
  );
}
