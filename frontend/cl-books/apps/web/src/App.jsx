import React from 'react';
import { BrowserRouter, Route, Routes } from 'react-router-dom';
import HomePage from '@/pages/HomePage.jsx';
import AdminDashboard from '@/pages/admin/AdminDashboard.jsx';
import { CartProvider } from '@/hooks/useCart.jsx';

export default function App() {
  return (
    <CartProvider>
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<HomePage />} />
          <Route path="/admin/dashboard" element={<AdminDashboard />} />
        </Routes>
      </BrowserRouter>
    </CartProvider>
  );
}
