class Instituicao
  include MongoMapper::Document

  key :numero_leitos, Integer
  key :nome, String
  key :endereco, String
  key :bairro, String
  key :cidade, String
  key :complemento, String
  key :estado, String
  
  many :setores
  many :equipes_internas
  many :marcas
  many :equipamentos
end
