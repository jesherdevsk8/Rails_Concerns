class ClientesController < ApplicationController
  before_action :set_cliente, only: %i[ show update destroy ]
  include BuscaPorNome

  # GET /clientes/ativos
  def ativos
    @clientes = Cliente.ativos
    render json: @clientes
  end

  # GET /clientes
  def index
    @clientes = busca_por_nome(Cliente.all)

    render json: @clientes
  end

  # GET /clientes/1
  def show
    render json: @cliente
  end

  # POST /clientes
  def create
    @cliente = Cliente.new(cliente_params)

    if @cliente.save
      render json: @cliente, status: :created, location: @cliente
    else
      render json: @cliente.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /clientes/1
  def update
    if @cliente.update(cliente_params)
      render json: @cliente
    else
      render json: @cliente.errors, status: :unprocessable_entity
    end
  end

  # DELETE /clientes/1
  def destroy
    @cliente.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cliente
      @cliente = Cliente.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cliente_params
      params.require(:cliente).permit(:nome, :telefone, :responsavel, :ativo)
    end
end
