# encoding: utf-8

class Notificacao
  include MongoMapper::Document

  key :numero, Integer
  key :descricao_falha, String
  key :patrimonio, String
  key :despachada, Boolean, :default => false
  key :data_abertura, Date
  key :data_despacho, Date
  key :tipo_despacho, Integer, :default => 0
  key :motivo_cancelamento, String
  key :instituicao_id, ObjectId
  key :setor_id, ObjectId
  key :item_id, ObjectId
  key :usuario_id, ObjectId
  key :status_anterior, Integer
  
  def estado
    if tipo_despacho == 1
      "Acatada"
    elsif tipo_despacho == 2
      "Cancelada"
    else
      "Aguardando avaliação"
    end
  end
  
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
