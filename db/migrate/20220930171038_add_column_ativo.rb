class AddColumnAtivo < ActiveRecord::Migration[7.0]
  def change
    add_column :clientes, :ativo, :boolean, default: true
    add_column :funcionarios, :ativo, :boolean, default: true
  end
end