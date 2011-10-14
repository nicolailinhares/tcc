class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_instituicao, :set_usuario, :authenticate_usuario!
  layout :escolhe_layout
  protected
  def set_instituicao
    @instituicao = Instituicao.find(session[:instituicao_id])
    @nivel = session[:nivel]
    @controlador = controller_name
  end
  
  def set_usuario
    @usuario = current_usuario
  end
  
  def escolhe_layout
   #Escolhe verificando se o usuário está logado, utilizando o método usuario_signed_in? do devise
   usuario_signed_in? ? 'application' : 'login'
  end
  
end
