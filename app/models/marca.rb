# encoding: utf-8

class Marca < Validacao
  include MongoMapper::EmbeddedDocument

  key :nome, String
  key :e_nacional, Boolean
  attr_accessor :pai
  
  many :modelos
  
  def valida pai
   self.superpai= pai
   valida_presenca_de :nome
   valida_unicidade_de :nome, pai.marcas
  end
  
  def nacionalidade
    if e_nacional
      "Nacional"
    else
      "Estrangeira"
    end
  end  
  
end
