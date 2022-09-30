module Ativo
  extend ActiveSupport::Concern

  included do
    scope :ativos, -> { where(ativo: true)}
  end
end