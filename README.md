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