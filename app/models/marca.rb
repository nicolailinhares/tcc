class Marca
  include MongoMapper::EmbeddedDocument

  key :nome, String
  key :e_nacional, Boolean
  
  many :modelos
  def nacionalidade
    if e_nacional
      "Nacional"
    else
      "Estrangeira"
    end
  end  
  
end
