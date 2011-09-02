require 'test_helper'

class EquipamentosControllerTest < ActionController::TestCase
  setup do
    @equipamento = equipamentos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:equipamentos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create equipamento" do
    assert_difference('Equipamento.count') do
      post :create, :equipamento => @equipamento.attributes
    end

    assert_redirected_to equipamento_path(assigns(:equipamento))
  end

  test "should show equipamento" do
    get :show, :id => @equipamento.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @equipamento.to_param
    assert_response :success
  end

  test "should update equipamento" do
    put :update, :id => @equipamento.to_param, :equipamento => @equipamento.attributes
    assert_redirected_to equipamento_path(assigns(:equipamento))
  end

  test "should destroy equipamento" do
    assert_difference('Equipamento.count', -1) do
      delete :destroy, :id => @equipamento.to_param
    end

    assert_redirected_to equipamentos_path
  end
end
