class Instituicao
  include MongoMapper::Document

  key :numero_leitos, Integer
  key :nome, String
  key :endereco, String
  key :bairro, String
  key :cidade, String
  key :complemento, String
  key :estado, String
  key :criador_id, ObjectId
  
  many :permissoes
  many :setores
  many :equipes_internas
  many :marcas
  many :equipamentos
  
  after_save :cria_permissao_gerente
  
  private
  def cria_permissao_gerente
    usuario = Usuario.find(criador_id)
    permissao = Permissao.new(:usuario_id => usuario.id, :email => usuario.email, :instituicao_id => id, :nivel => 3)
    permissao.save
  end
  
end
