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