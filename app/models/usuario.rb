class Usuario
  include MongoMapper::Document

  key :nome, String
  key :telefone, String
  key :nivel, Integer

end
