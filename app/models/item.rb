class Item
  include MongoMapper::Document

  key :numero_serie, String
  key :patrimonio, String
  key :data_aquisicao, Date
  key :status, Integer
  key :valor_aquisicao, Integer
  key :tipo_recurso, Integer
  key :vencimento_garantia, Date

end
