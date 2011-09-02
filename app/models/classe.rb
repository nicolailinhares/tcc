class Classe
  include MongoMapper::Document

  key :titulo, String
  key :requer_registro, Boolean

end
