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
  
end
