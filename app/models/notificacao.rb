class Notificacao
  include MongoMapper::EmbeddedDocument

  key :descricao_falha, String
  key :patrimonio, String
  key :despachada, Boolean
  key :data_abertura, Date
  key :data_despacho, Date
  key :tipo_despacho, Integer
  key :motivo_cancelamento, String
  
  def self.texto_despacho n
    TIPOS_DE_DESPACHO[n]
  end
  
  def self.despachos
    NIVEIS.to_a.sort
  end
  
   def nome_despacho
     TIPOS_DE_DESPACHO[tipo_despacho]
  end
  
  private
  TIPOS_DE_DESPACHO =
  {
    1 => 'Abertura de ordem de serviço',
    2 => 'Cancelamento'
  } 
end
