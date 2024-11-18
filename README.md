# Maps Kansi

Simples aplicativo Flutter Android para pesquisa e registro de CEP's. 

Um aplicativo de mapa, que ao buscar determinado CEP, mostra a localização no mapa, com opção de salvar endereço para uso futuro. 

Como funcionalidades, na tela inicial podemos pesquisar o CEP e salvar o endereço, adicionando número e complemento. Ao salvar endereço, é possível listá-los na aba "Caderneta", onde é possível remover um item clicando no ícone de bookmark, ou clicar em cima do endereço para vê-lo no mapa e/ou editá-lo.

## Conceitos técnicos
O aplicativo foi desenvolvido utilizando a versão 3.19.1 do Flutter.

Para visualização do mapa foi utilizado o package [google_maps_flutter](https://pub.dev/packages/google_maps_flutter), como a funcionalidade de pesquisa de endereços e CEP's da google não é gratuita, foi utilizada a API [Brasil API](https://brasilapi.com.br/) para busca dos CEP's. Para gerência de estados, [cubit (Bloc)](https://pub.dev/packages/flutter_bloc) foi a tecnologia escolhida, para injeção de dependências, o package [get_it](https://pub.dev/packages/get_it). Envolvendo dados, dois packages foram utilizados, [Dio](https://pub.dev/packages/dio) para requisições HTTP e, para banco de dados local, [sqflite](https://pub.dev/packages/sqflite), o SQLite para Flutter, que trata de dados relacionais.

## Estrutura das pastas
Dentro da pasta [lib](/lib/) temos a estrutura de pastas abaixo para organização do projeto.

```
app
└───core // Diretório para utilitários, services, etc
│   └───utils // Consts do app e utilitários
└───data
│   └───datasources // Acesso à fonte de dados local e web
│   └───models // Classes centrais do app
│   └───repositories // Repositórios para busca de dados
└───ui
│   └───routes // Arquivos de rotas do app
│   └───theme //  Arquivos de temas, cores e fontes
│   └───widgets // Widgets globais para todo app
│   └───screens // Telas do app
│       └───example // Exemplo de tela
│           └───cubits // Cubits e states da tela
│           └───widgets // Widgets locais
│           │   example_screen.dart
│   dependencies.dart // Injeção de dependência
main.dart
```
