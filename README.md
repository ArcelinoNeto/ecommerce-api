# Ecommerce API

Ecommerce API is a Ruby on Rails backend application designed to simulate the core structure of an e-commerce platform, including authentication, administrative management and storefront operations.

The project was created to demonstrate RESTful API architecture, token-based authentication, relational modeling and separation between administrative and customer-facing domains.

## Features

* Token-based authentication with Devise Token Auth
* Administrative area for managing categories, products and orders
* Public storefront API
* Customer order creation
* Product catalog management
* Relational database modeling
* RESTful API architecture
* PostgreSQL database

## Tech Stack

* Ruby 2.7.1
* Ruby on Rails 6.1
* PostgreSQL
* Devise Token Auth

## Authentication

Authentication routes are available at:

```text
/auth/v1/user
```

Authenticated requests require the headers returned by `devise_token_auth` login:

```text
access-token
client
uid
```

## Seed Users

The seed file creates two default users:

| Role     | Email                                               | Password    |
| :------- | :-------------------------------------------------- | :---------- |
| Admin    | [admin@example.com](mailto:admin@example.com)       | password123 |
| Customer | [customer@example.com](mailto:customer@example.com) | password123 |

## Admin API

Administrative routes require a user with `profile: admin`.

### Categories

```text
GET    /admin/v1/categories
POST   /admin/v1/categories
GET    /admin/v1/categories/:id
PATCH  /admin/v1/categories/:id
DELETE /admin/v1/categories/:id
```

### Products

```text
GET    /admin/v1/products
POST   /admin/v1/products
GET    /admin/v1/products/:id
PATCH  /admin/v1/products/:id
DELETE /admin/v1/products/:id
```

### Orders

```text
GET    /admin/v1/orders
GET    /admin/v1/orders/:id
PATCH  /admin/v1/orders/:id
```

### Product Example

```json
{
  "product": {
    "category_id": 1,
    "name": "Wireless Keyboard",
    "description": "Compact Bluetooth keyboard",
    "price": 199.9,
    "stock_quantity": 25,
    "active": true
  }
}
```

## Storefront API

Public catalog routes:

```text
GET /storefront/v1/categories
GET /storefront/v1/categories/:id
GET /storefront/v1/products
GET /storefront/v1/products/:id
```

Order routes require authenticated users:

```text
GET  /storefront/v1/orders
GET  /storefront/v1/orders/:id
POST /storefront/v1/orders
```

### Order Example

```json
{
  "order": {
    "shipping_address": "Rua Exemplo, 123",
    "notes": "Entregar no periodo da tarde",
    "items": [
      { "product_id": 1, "quantity": 2 }
    ]
  }
}
```

## Setup

Install dependencies:

```bash
bundle install
```

Create, migrate and seed the database:

```bash
bin/rails db:create db:migrate db:seed
```

Start the application:

```bash
bin/rails s
```

## Project Goals

This project demonstrates:

* RESTful API development with Ruby on Rails
* Token-based authentication
* Separation between admin and storefront domains
* E-commerce relational modeling
* Order management workflows
* Product and category management
* API organization using Rails conventions
* Backend architecture for scalable applications

## Architecture Notes

The project follows a modular API structure separating administrative operations from storefront consumption.

The administrative layer is responsible for managing products, categories and orders, while the storefront layer exposes public catalog information and customer order flows.

This architecture simulates common real-world e-commerce backend scenarios.

## Future Improvements

Some planned improvements for the project include:

* Automated tests with RSpec
* Swagger/OpenAPI documentation
* Docker support
* CI/CD pipeline
* Background job processing
* Payment gateway integration
* Inventory reservation system
* Caching strategies
* Rate limiting
* Webhook support

## Portfolio Notes

This project was maintained as a portfolio case study because it represents common backend scenarios involving authentication, product management, order processing and modular API organization for e-commerce platforms.
