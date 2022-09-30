## Entendendo Concerns

- Crie uma API

```ruby
rails new api --api
```

- Gerar duas classes para exemplo

```ruby
rails g scaffold cliente nome:string telefone:string responsavel:string

rails g scaffold funcionario nome:string telefone:string setor:string
```

- Rode a migration

```ruby
rails db:migrate
```

## Testar o POST

```bash

curl -d '{"nome":"Jesher", "telefone":"16-99999-9999", "responsavel":"Tobias"}' -H "Content-Type: application/json" -X POST http://localhost:3000/clientes

curl -d '{"nome":"Priscilla", "telefone":"16-99999-9999", "setor":"Recursos Humanos"}' -H "Content-Type: application/json" -X POST http://localhost:3000/funcionarios

```

## Acrescentar um campo a mais para teste

- Adicionar coluna nas tabelas clientes e funcionarios e rodar migration

```ruby
rails g migration add_column_ativo

add_column :clientes, :ativo, :boolean, default: true
add_column :funcionarios, :ativo, :boolean, default: true

rails db:migrate
```

## Permitir parametros no controller

```ruby

def cliente_params
  params.require(:cliente).permit(:nome, :telefone, :responsavel, :ativo)
end

def funcionario_params
  params.require(:funcionario).permit(:nome, :telefone, :setor, :ativo)
end

```
## Testar o POST novamente

```bash

curl -d '{"nome":"José", "telefone":"16-99999-8889", "responsavel":"Marcos", "ativo":"false"}' -H "Content-Type: application/json" -X POST http://localhost:3000/clientes

curl -d '{"nome":"Maria", "telefone":"16-99999-9999", "setor":"Compras", "ativo":"false"}' -H "Content-Type: application/json" -X POST http://localhost:3000/funcionarios

```

## Criação do concern

```ruby
touch app/models/concerns/ativo.rb

module Ativo
  extend ActiveSupport::Concern

  included do
    scope :ativo, -> { where(ativo: true)}
  end
end

touch app/controllers/concerns/busca_por_nome.rb

module BuscaPorNome
  extend ActiveSupport::Concern

  included do
    def busca_por_nome(busca_nome)
      if params[:nome].present?
        return busca_nome.where(nome: params[:nome])
      else
        return busca_nome
      end
    end
  end
end
```

- Incluir concern no model funcionarios e clientes

```ruby
api/app/models/cliente.rb
include Ativo

api/app/models/funcionarios.rb
include Ativo

app/controllers/funcionarios_controller.rb
include BuscaPorNome

app/controllers/clientes_controller.rb
include BuscaPorNome

```

## ROTAS - route.rb
```ruby
Rails.application.routes.draw do
  resources :funcionarios
  get 'funcionarios_ativos', to: 'funcionarios#ativos'
  resources :clientes
  get 'clientes_ativos', to: 'clientes#ativos'
end

127.0.0.1:3000/funcionarios_ativos
127.0.0.1:3000/clientes_ativos

127.0.0.1:3000/funcionarios?nome=Priscilla
127.0.0.1:3000/clientes?nome=Jesher

```

[Check funcionarios_controller.rb](app/controllers/funcionarios_controller.rb)

[Check clientes_controller.rb](app/controllers/clientes_controller.rb)