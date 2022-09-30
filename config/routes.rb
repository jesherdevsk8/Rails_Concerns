Rails.application.routes.draw do
  resources :funcionarios
  get 'funcionarios_ativos', to: 'funcionarios#ativos'
  resources :clientes
  get 'clientes_ativos', to: 'clientes#ativos'
end
