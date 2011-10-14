class Setor
  include MongoMapper::EmbeddedDocument

  key :nome, String
  key :endereco, String
  key :bairro, String
  key :cidade, String
  key :estado, String
  key :ids_de_usuario, Array
  key :responsavel_id, ObjectId

  many :usuarios, :in => :ids_de_usuario
  many :itens
  
  many :salas
  before_save :adiciona_usuario
  after_save :se_adiciona_ao_usuario
  
  def adiciona_usuario
    self.ids_de_usuario << self.responsavel_id
    ids_de_usuario.uniq!
  end
  
  def se_adiciona_ao_usuario
    usuario = Usuario.find(self.responsavel_id)
    usuario.setores_ids << self.id
    usuario.setores_ids.uniq!
    usuario.save
  end
end
