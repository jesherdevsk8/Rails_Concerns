require "test_helper"

class FuncionariosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @funcionario = funcionarios(:one)
  end

  test "should get index" do
    get funcionarios_url, as: :json
    assert_response :success
  end

  test "should create funcionario" do
    assert_difference("Funcionario.count") do
      post funcionarios_url, params: { funcionario: { nome: @funcionario.nome, setor: @funcionario.setor, telefone: @funcionario.telefone } }, as: :json
    end

    assert_response :created
  end

  test "should show funcionario" do
    get funcionario_url(@funcionario), as: :json
    assert_response :success
  end

  test "should update funcionario" do
    patch funcionario_url(@funcionario), params: { funcionario: { nome: @funcionario.nome, setor: @funcionario.setor, telefone: @funcionario.telefone } }, as: :json
    assert_response :success
  end

  test "should destroy funcionario" do
    assert_difference("Funcionario.count", -1) do
      delete funcionario_url(@funcionario), as: :json
    end

    assert_response :no_content
  end
end
