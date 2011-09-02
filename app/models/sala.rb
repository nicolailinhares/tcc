class Sala
  include MongoMapper::Document

  key :nome, String
  key :lista_itens, Array
  key :localizacao, String

end
