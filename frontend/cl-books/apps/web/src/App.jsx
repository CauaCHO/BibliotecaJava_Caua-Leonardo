import React from 'react';
import HomePage from '@/pages/HomePage.jsx';
import { CartProvider } from '@/hooks/useCart.jsx';

export default function App() {
  return (
    <CartProvider>
      <HomePage />
    </CartProvider>
  );
}
