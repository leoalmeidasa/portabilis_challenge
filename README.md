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

● link: [Teste API Postman](https://www.postman.com/devtechbrazil/workspace/testes/collection/14377778-93803a68-b659-4cae-ac7f-3b854b500296?action=share&creator=14377778)

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

## Exemplos de requisições

### `POST /auth` - Criar Usuario Admin

Cria um novo usuário com perfil de administrador.

**URL:** `https://portabilis-challenge.fly.dev/auth`

**Body (form-data):**

| Parâmetro           | Exemplo           | Descrição                               |
| :------------------ | :---------------- | :-------------------------------------- |
| `email`             | `teste2@gmail.com`| Endereço de e-mail do usuário.          |
| `name`              | `teste`           | Nome do usuário.                        |
| `password`          | `12345678`        | Senha do usuário.                       |
| `password_confirmation`| `12345678`        | Confirmação da senha.                   |
| `role`              | `admin`           | Perfil do usuário (deve ser `admin`).   |

**Exemplo de Requisição (cURL):**

```bash
curl --location 'https://portabilis-challenge.fly.dev/auth' \
    --form 'email="teste2@gmail.com"' \
    --form 'name="teste"' \
    --form 'password="12345678"' \
    --form 'password_confirmation="12345678"' \
    --form 'role="admin"'
```

### `PATCH /api/v1/users/4/inactivate` - Inativar ou Ativar usuários

Inativa ou ativa um usuário específico.

**URL:** `https://portabilis-challenge.fly.dev/api/v1/users/4/inactivate`

**Headers:**

| Parâmetro           | Exemplo                   | Descrição                               |
| :------------------ | :------------------------ | :-------------------------------------- |
| `access-token`      | `M3-deeEaStGjVr5_TTvkjA`  | Token de acesso do usuário.             |
| `client`            | `JJ4MDWsTosf7o_J_2M3XXA`  | ID do cliente.                          |
| `uid`               | `leo@gmail.com`           | E-mail do usuário.                      |

**Exemplo de Requisição (cURL):**

```bash
curl --location --request PATCH \'https://portabilis-challenge.fly.dev/api/v1/users/4/inactivate\' \
    --header \'access-token: M3-deeEaStGjVr5_TTvkjA\' \
    --header \'client: JJ4MDWsTosf7o_J_2M3XXA\' \
    --header \'uid: leo@gmail.com\'
```

### `POST /auth/sign_in` - Login

Realiza o login de um usuário.

**URL:** `https://portabilis-challenge.fly.dev/auth/sign_in`

**Body (form-data):**

| Parâmetro           | Exemplo           | Descrição                               |
| :------------------ | :---------------- | :-------------------------------------- |
| `email`             | `leo@gmail.com`   | Endereço de e-mail do usuário.          |
| `password`          | `12345678`        | Senha do usuário.                       |

**Exemplo de Requisição (cURL):**

```bash
curl --location 'https://portabilis-challenge.fly.dev/auth/sign_in' \
    --form 'email="leo@gmail.com"' \
    --form 'password="12345678"'
```

### `GET /api/v1/users` - Lista usuários

Retorna uma lista de todos os usuários.

**URL:** `https://portabilis-challenge.fly.dev/api/v1/users`

**Headers:**

| Parâmetro           | Exemplo                   | Descrição                               |
| :------------------ | :------------------------ | :-------------------------------------- |
| `access-token`      | `A_iDmEAd6EOZ7sPGF0LXtA`  | Token de acesso do usuário.             |
| `client`            | `RoOf10cOrnEX1AZx8wf6Vw`  | ID do cliente.                          |
| `uid`               | `leo@gmail.com`           | E-mail do usuário.                      |

**Exemplo de Requisição (cURL):**

```bash
curl --location 'https://portabilis-challenge.fly.dev/api/v1/users' \
    --header 'access-token: A_iDmEAd6EOZ7sPGF0LXtA' \
    --header 'client: RoOf10cOrnEX1AZx8wf6Vw' \
    --header 'uid: leo@gmail.com'
```

### `DEL /api/v1/users/4` - Deletar Usuário

Exclui um usuário específico.

**URL:** `https://portabilis-challenge.fly.dev/api/v1/users/4`

**Headers:**

| Parâmetro           | Exemplo                   | Descrição                               |
| :------------------ | :------------------------ | :-------------------------------------- |
| `access-token`      | `M3-deeEaStGjVr5_TTvkjA`  | Token de acesso do usuário.             |
| `client`            | `JJ4MDWsTosf7o_J_2M3XXA`  | ID do cliente.                          |
| `uid`               | `leo@gmail.com`           | E-mail do usuário.                      |

**Exemplo de Requisição (cURL):**

```bash
curl --location --request DELETE \'https://portabilis-challenge.fly.dev/api/v1/users/4\' \
    --header \'access-token: M3-deeEaStGjVr5_TTvkjA\' \
    --header \'client: JJ4MDWsTosf7o_J_2M3XXA\' \
    --header \'uid: leo@gmail.com\'
```
