# encoding: utf-8

# Classe que representa uma cidade
class Cidade
  include MongoMapper::EmbeddedDocument

  key :nome, String
  
  embedded_in :estado
end