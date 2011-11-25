# encoding: utf-8

class Permissao
  include MongoMapper::Document
  
  key :instituicao_id, ObjectId
  key :usuario_id, ObjectId
  key :email, String
  key :nivel, Integer
  key :nome_usuario, String
  key :nome_instituicao, String
  key :resolvida, Boolean, :default => true
  key :setores_ids, Array
  
  Permissao.ensure_index :email
  belongs_to :instituicao
  before_save :adere_email
  
  def self.texto_nivel n
    NIVEIS[n]
  end
  
  def self.niveis
    NIVEIS.to_a.sort
  end
  
  def nome_nivel
    NIVEIS[nivel]
  end
  
  private
  NIVEIS =
  {
    1 => 'Profissional de saúde',
    2 => 'Técnico',
    3 => 'Gerente'
  }
  
  def adere_email
    usuario = Usuario.find(self.usuario_id)
    self.email = usuario.email
    self.nome_usuario = usuario.nome
    instituicao = Instituicao.find(self.instituicao_id)
    self.nome_instituicao = instituicao.nome
  end 
end