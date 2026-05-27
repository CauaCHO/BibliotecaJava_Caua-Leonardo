const CONTEXT_PATH = '/BibliotecaJava_Caua-Leonardo';
const API_BASE = `${CONTEXT_PATH}/api`;

function centsToBRL(cents) {
  const value = Number(cents || 0) / 100;
  return value.toLocaleString('pt-BR', {
    style: 'currency',
    currency: 'BRL'
  });
}

function moneyToCents(value) {
  const number = Number(String(value || '0').replace(',', '.'));
  return Math.round(number * 100);
}

function mapLivroToProduct(livro) {
  const priceInCents = moneyToCents(livro.valorLivro);

  return {
    id: livro.id,
    title: livro.nomeLivro,
    subtitle: livro.autor,
    description: `Livro ${livro.nomeLivro} escrito por ${livro.autor}. Categoria: ${livro.nomeCategoria || 'Sem categoria'}.`,
    image: livro.capaLivro || 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=400&h=600&fit=crop',
    category: livro.nomeCategoria || 'Sem categoria',
    isbn: livro.isbn,
    variants: [
      {
        id: livro.id,
        title: 'Padrão',
        price_in_cents: priceInCents,
        price_formatted: centsToBRL(priceInCents),
        sale_price_in_cents: null,
        sale_price_formatted: null,
        inventory_quantity: 99
      }
    ]
  };
}

async function getJson(path) {
  const response = await fetch(`${API_BASE}${path}`);

  if (!response.ok) {
    throw new Error(`Erro ao buscar dados: ${response.status}`);
  }

  return response.json();
}

export async function getProducts({ limit = 50 } = {}) {
  const livros = await getJson('/livros');
  const products = livros.map(mapLivroToProduct).slice(0, limit);

  return {
    products,
    total: products.length
  };
}

export async function getProductById(id) {
  const livros = await getJson('/livros');
  const livro = livros.find((item) => String(item.id) === String(id));

  if (!livro) {
    throw new Error('Produto não encontrado');
  }

  return mapLivroToProduct(livro);
}

export async function getCategories() {
  const categorias = await getJson('/categorias');

  return categorias.map((categoria) => ({
    id: categoria.id,
    name: categoria.nomeCategoria,
    description: categoria.descricao
  }));
}

export async function getStates() {
  const estados = await getJson('/estados');

  return estados.map((estado) => ({
    id: estado.id,
    name: estado.nomeEstado,
    code: estado.siglaEstado
  }));
}

export async function createCheckout() {
  return {
    url: '/checkout'
  };
}
