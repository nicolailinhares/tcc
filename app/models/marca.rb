class Marca
  include MongoMapper::Document

  key :nome, String
  key :e_nacional, Boolean
  
end
