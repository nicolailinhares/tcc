class Item
  include MongoMapper::EmbeddedDocument

  key :numero_serie, String
  key :patrimonio, String
  key :data_aquisicao, Date
  key :status, Integer
  key :valor_aquisicao, Float
  key :tipo_recurso, Integer
  key :vencimento_garantia, Date
  key :sala_id, ObjectId
  key :equipamento_id, ObjectId
  key :nome_equipamento, String
  
  many :ordens_de_servico, :as => :ordenado
  one :modelo

  def self.texto_tipo_de_recurso n
    TIPOS_DE_RECURSO[n]
  end
  
  def self.tipos_de_recurso
    TIPOS_DE_RECURSO.to_a.sort
  end
  
   def nome_tipo_de_recurso
    TIPOS_DE_RECURSO[tipo_de_recurso]
  end
  
  def self.texto_status n
    LISTA_DE_STATUS[n]
  end
  
  def self.lista_de_status
    LISTA_DE_STATUS.to_a.sort
  end
  
   def nome_status
    LISTA_DE_STATUS[status]
  end
  
  private
  TIPOS_DE_RECURSO =
  {
    1 => 'Próprio',
    2 => 'Comodato',
    3 => 'Doação'
  } 
  LISTA_DE_STATUS =
  {
    1 => 'Em funcionamento',
    2 => 'Aguardando instalação',
    3 => 'Em manutenção preventiva',
    4 => 'Em manutenção corretiva',
    5 => 'Aguardando manutenção corretiva'
  }
end
