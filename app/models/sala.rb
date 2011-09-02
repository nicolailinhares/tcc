class Sala
  include MongoMapper::EmbeddedDocument

  key :nome, String
  key :localizacao, String
  key :ids_de_item, Array
  
  many :itens, :in => :ids_de_item
end
