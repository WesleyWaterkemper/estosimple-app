Sistema de gestão de estoque como parte do curso de Análise e Desenvolvimento de Sistemas (ADS).

## 👥 Integrante
* **Integrante:** [Wesley Nobuyuki Tomimori Waterkemper]
* **Turma:** [5º ADS A]

## 📝 Descrição do Projeto
O **Esto-simple** é uma solução completa para o gerenciamento de inventário. O aplicativo permite a criação, leitura, atualização e exclusão (CRUD) de produtos, integrando um frontend moderno em Flutter com um backend robusto em C# .NET.

### Funcionalidades Principais:
* **Listagem de Produtos:** Visualização clara do estoque com busca via API.
* **Gestão de Inventário:** Cadastro de produtos com SKU, descrição e preço.
* **Interface Moderna:** Navegação declarativa com GoRouter e gerenciamento de estado com Provider.

## 🌐 API Utilizada
O backend do projeto está hospedado no Railway, provendo uma API RESTful persistente em PostgreSQL.

* **Nome:** Estopay Backend API (.NET 10)
* **URL Base:** `https://estopay-app-production.up.railway.app/api`

## 🚀 Instruções para Rodar o Projeto

Siga os passos abaixo para executar o aplicativo em seu ambiente local:

1. **Clonar o repositório:**
   git clone [URL_DO_SEU_REPOSITORIO]

2. **Entrar na pasta do projeto:**
   cd estopay_app

3. **Instalar as dependências:**
   flutter pub get

4. **Executar o aplicativo na seguinte porta configurada do CORS:**
   flutter run -d chrome --web-port=3000