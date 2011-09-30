class Modelo
  include MongoMapper::EmbeddedDocument

  key :nome, String
  key :marca_id, ObjectId
  key :equipamento_id, ObjectId
  key :nome_marca, String
  
end
