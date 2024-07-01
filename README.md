# CarWish

**CarWish** é um aplicativo desenvolvido para listar carros, mostrar detalhes sobre cada carro e permitir que os usuários se manifestem se estiverem interessados em um carro específico. O aplicativo também possui uma área de desenvolvimento para testes de funcionalidades e manutenção do banco de dados.

![Logo do Projeto](imagens/logo.png) <!-- Substitua com a imagem do logo do seu projeto -->

## Tabelas de Conteúdo

- [Sobre o Projeto](#sobre-o-projeto)
- [Funcionalidades](#funcionalidades)
- [Como Usar](#como-usar)
- [Capturas de Tela](#capturas-de-tela)
- [Estrutura do Código](#estrutura-do-código)
- [Configuração do Ambiente](#configuração-do-ambiente)
- [Contribuindo](#contribuindo)
- [Licença](#licença)

## Sobre o Projeto

O **CarWish** é um aplicativo desenvolvido utilizando **Flutter** para listar carros, mostrar detalhes e permitir o envio de interesse por um carro. O projeto foi desenvolvido com o objetivo de demonstrar as habilidades em Flutter e soluções de backend para aplicações móveis.

O app conta com uma área de desenvolvimento para testes de funcionalidades e manutenção do banco de dados, e foi construído com um prazo de 2 dias para a sua execução.

## Funcionalidades

- **Tela Inicial**: Exibe uma lista de carros obtidos de um endpoint de API. Os carros são exibidos em uma lista rolável.
- **Página de Detalhes do Carro**: Ao clicar em um carro, você é direcionado para uma página com os detalhes do carro e um formulário para expressar interesse.
- **Formulário de Interesse**: Permite ao usuário preencher dados (nome, telefone e e-mail) para demonstrar interesse em um carro. O botão de envio só é ativado quando todos os campos são preenchidos corretamente.
- **Área de Desenvolvimento**: Seção acessível para teste de envio de dados, gerenciamento de leads, e reset do banco de dados.
- **Menu Lateral**: Inclui opções para navegar entre a tela inicial, a página sobre nós e a área de desenvolvimento.

## Como Usar

### Inicialização do Projeto

1. **Clone o Repositório**

   ```bash
   git clone https://github.com/seu-usuario/carwish.git

   ```

2. **Navegue até o diretório do projeto**

   ```bash
   cd carwish

   ```

3. **Instale as dependências**

   ```bash
   flutter pub get

   ```

4. **Execute o aplicativo**

   ```bash
   flutter run

   ```