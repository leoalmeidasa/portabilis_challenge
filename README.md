# Teste para vaga Ruby On Rails Pleno - Portabilis


## Requisitos

● Disponivel no Link: [Project](https://github.com/users/leoalmeidasa/projects/7)

## Dependências

- Ruby 3.2.0
- Rails 8.0.2
- Postgres

## API no Fly.io

● link: https://portabilis-challenge.fly.dev/

## Documentação da API

● link: [Documentation](https://documenter.getpostman.com/view/14377778/2sB34oDdXu)
● link: [TESTE API POSTMAN](https://www.postman.com/devtechbrazil/workspace/testes/collection/14377778-93803a68-b659-4cae-ac7f-3b854b500296?action=share&creator=14377778)

## Setup
```bash
git clone https://github.com/leoalmeidasa/portabilis_challenge.git
cd portabilis_challenge

# installation of dependencies
bundle install


# creation of database and tables
rails db:create
rails db:migrate

# Run the project
rails s
```
 Abrir o link localhost:3000

## Tests

![Tests](https://github.com/peimelo/blog_api/actions/workflows/ruby.yml/badge.svg)

To run the tests:

```bash
bundle exec rspec
```
