# encoding: utf-8

class Sala < Validacao
  include MongoMapper::EmbeddedDocument

  key :nome, String
  key :localizacao, String
  attr_accessor :pai
  many :itens
  
  def valida pai
    self.superpai = pai.superpai
    valida_presenca_de :nome
    valida_unicidade_de :nome, pai.salas
  end
end
