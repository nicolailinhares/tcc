class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_instituicao, :set_usuario
  
  protected
  def set_instituicao
    @instituicao = Instituicao.first.nil? ? Instituicao.new : Instituicao.first
  end
  
  def set_usuario
    @usuario = @instituicao.usuarios.first.nil? ? @instituicao.usuarios.build : @instituicao.usuarios.first
  end
  
end
