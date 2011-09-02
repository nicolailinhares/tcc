class Equipamento
  include MongoMapper::Document

  key :nome, String
  key :criticidade, Integer, :default => 1
  key :ids_de_marca, Array
  belongs_to :categoria
  
  many :modelos
  many :marcas, :in => :ids_de_marca
  def self.texto_criticidade n
    CRITICIDADES[n]
  end
  
  def self.criticidades
    CRITICIDADES.to_a.sort
  end
  
   def nome_criticidade_execucao
    CRITICIDADES[criticidade]
  end
  
  private
  CRITICIDADES =
  {
    1 => 'Profissional de saúde',
    2 => 'Técnico',
    3 => 'Gerente'
  } 
end
