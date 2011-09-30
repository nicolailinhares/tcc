class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_instituicao, :set_usuario
  
  protected
  def set_instituicao
    @instituicao = Instituicao.first
  end
  
  def set_usuario
    @usuario = @instituicao.usuarios.first
  end
  
end
