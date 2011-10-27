class Aviso
  include MongoMapper::EmbeddedDocument
  
  key :conteudo, String
  key :tipo, Integer
  key :instituicao_id, ObjectId
  
  def cor
    CORES[tipo]
  end
  
  CORES = {
    1 => 'green',
    2 => 'paleGreen',
    3 => 'blue',
    4 => 'yellow',
    5 => 'red'
  }
end
