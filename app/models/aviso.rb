class Aviso
  include MongoMapper::Document
  
  key :conteudo
  key :tipo
  
  def cor
    CORES[tipo]
  end
  
  CORES = {
    1 => 'red'
  }
end
