class Setor
  include MongoMapper::Document

  key :nome, String
  key :endereco, String
  key :bairro, String
  key :cidade, String
  key :estado, String

end
