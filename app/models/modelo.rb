# encoding: utf-8

class Modelo
  include MongoMapper::EmbeddedDocument

  key :nome, String
  key :marca_id, ObjectId
  key :equipamento_id, ObjectId
  key :instituicao_id, ObjectId
  key :nome_marca, String
  key :nome_equipamento, String
   
end
