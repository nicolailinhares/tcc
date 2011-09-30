class Sala
  include MongoMapper::EmbeddedDocument

  key :nome, String
  key :localizacao, String
  
  many :itens
end
