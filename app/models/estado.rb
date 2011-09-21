# encoding: utf-8

# Classe que representa um estado
class Estado
  include MongoMapper::Document

  # Ordena sempre por ordem alfabética
  scope :all, sort(:sigla.desc)

  key :sigla, String
  
  # Validações
  validates_uniqueness_of :sigla, :message => 'já está em uso'
  validates_length_of :sigla, :is => 2, :message => ' deve possuir 2 caracteres'

  many :cidades
  
  def self.lista_estados
    return LISTA_ESTADOS
  end
  
  private
  
  LISTA_ESTADOS = ['AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO']
  #LISTA_ESTADOS = ['MG']
end
