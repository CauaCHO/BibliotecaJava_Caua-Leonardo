/** @type {import('tailwindcss').Config} */
export default {
  content: [
    './index.html',
    './src/**/*.{js,jsx}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['DM Sans', 'sans-serif'],
        display: ['Playfair Display', 'serif']
      },
      colors: {
        background: '#0B1120',
        foreground: '#F8FAFC',
        panel: '#111827',
        amber: '#F59E0B',
        royal: '#3B82F6',
        neon: '#8B5CF6'
      }
    }
  },
  plugins: []
};
