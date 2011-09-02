class Setor
  include MongoMapper::EmbeddedDocument

  key :nome, String
  key :endereco, String
  key :bairro, String
  key :cidade, String
  key :estado, String
  key :ids_de_equipe, Array
  many :itens
  
  many :salas
  
end
