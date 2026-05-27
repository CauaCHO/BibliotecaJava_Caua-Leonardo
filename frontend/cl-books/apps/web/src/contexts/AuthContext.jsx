import React, { createContext, useContext, useEffect, useState } from 'react';

const AuthContext = createContext(null);

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const storedUser = localStorage.getItem('clbooks_admin_user');

    if (storedUser) {
      setUser(JSON.parse(storedUser));
    }

    setLoading(false);
  }, []);

  const login = async (email, password) => {
    if (email === 'admin@clbooks.com' && password === 'admin123') {
      const adminUser = {
        id: 1,
        name: 'Administrador',
        email,
        role: 'admin'
      };

      localStorage.setItem('clbooks_admin_user', JSON.stringify(adminUser));
      setUser(adminUser);

      return { success: true };
    }

    return {
      success: false,
      error: 'Credenciais inválidas'
    };
  };

  const logout = () => {
    localStorage.removeItem('clbooks_admin_user');
    setUser(null);
  };

  return (
    <AuthContext.Provider value={{ user, login, logout, loading }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => useContext(AuthContext);
