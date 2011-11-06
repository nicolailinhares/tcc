# encoding: utf-8

class Setor < Validacao
  include MongoMapper::EmbeddedDocument

  key :nome, String
  key :endereco, String
  key :bairro, String
  key :cidade, String
  key :estado, String
  key :ids_de_usuario, Array
  key :responsavel_id, ObjectId
  
  attr_accessor :pai
  
  many :usuarios, :in => :ids_de_usuario
  many :itens
  
  many :salas
  before_save :adiciona_usuario
  after_save :se_adiciona_ao_usuario
  
  def valida pai
   self.superpai= pai
   valida_presenca_de :nome
   valida_unicidade_de :nome, pai.setores
  end
  
  def afixa_avisos tipo, conteudo, instituicao_id
    aviso = Aviso.new(:instituicao_id => instituicao_id, :tipo => tipo, :conteudo => (conteudo+". O item está '"+Item.texto_status(tipo)+"'."))
    ids_de_usuario.each do |id|
      usuario = Usuario.find(id)
      usuario.avisos << aviso
      usuario.save
    end
  end

  private
  def adiciona_usuario
    self.ids_de_usuario << self.responsavel_id
    ids_de_usuario.uniq!
  end
  
  def se_adiciona_ao_usuario
    usuario = Usuario.find(self.responsavel_id)
    permissao = Permissao.where(:instituicao_id => @instituicao.id, :usuario_id => usuario.id)
    permissao.setores_ids << self.id
    permissao.setores_ids.uniq!
    permissao.save
  end
  
end
