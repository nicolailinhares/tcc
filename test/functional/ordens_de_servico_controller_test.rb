require 'test_helper'

class OrdensDeServicoControllerTest < ActionController::TestCase
  setup do
    @ordem_de_servico = ordens_de_servico(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ordens_de_servico)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ordem_de_servico" do
    assert_difference('OrdemDeServico.count') do
      post :create, :ordem_de_servico => @ordem_de_servico.attributes
    end

    assert_redirected_to ordem_de_servico_path(assigns(:ordem_de_servico))
  end

  test "should show ordem_de_servico" do
    get :show, :id => @ordem_de_servico.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @ordem_de_servico.to_param
    assert_response :success
  end

  test "should update ordem_de_servico" do
    put :update, :id => @ordem_de_servico.to_param, :ordem_de_servico => @ordem_de_servico.attributes
    assert_redirected_to ordem_de_servico_path(assigns(:ordem_de_servico))
  end

  test "should destroy ordem_de_servico" do
    assert_difference('OrdemDeServico.count', -1) do
      delete :destroy, :id => @ordem_de_servico.to_param
    end

    assert_redirected_to ordens_de_servico_path
  end
end
