# encoding: utf-8

class OrdemDeServico
  include MongoMapper::Document
  
  key :numero, Integer, :default => 1
  key :data_abertura, Date
  key :data_fechamento, Date
  key :custo_peca, Float
  key :custo_mao_de_obra, Float
  key :custo_frete, Float
  key :tipo_de_servico, Integer
  key :manutencao_interna, Boolean
  key :tipo_de_defeito, Integer
  key :descricao_falha, String
  key :descricao_solucao, String
  key :instituicao_id, ObjectId
  key :setor_id, ObjectId
  key :item_id, ObjectId
  key :usuario_id, ObjectId
  
  before_create :atribui_data
  
  def interna?
    if manutencao_interna
      'Sim'
    else
      'Não'
    end
  end
  
  def self.texto_tipo_de_defeito n
    TIPOS_DE_DEFEITO[n]
  end
  
  def self.tipos_de_defeito
    TIPOS_DE_DEFEITO.to_a.sort
  end
  
   def nome_tipo_defeito
    TIPOS_DE_DEFEITO[tipo_de_defeito]
  end
  
  def self.texto_tipo_de_servico n
    TIPOS_DE_SERVICO[n]
  end
  
  def self.tipos_de_servico
    TIPOS_DE_SERVICO.to_a.sort
  end
  
   def nome_tipo_servico
    TIPOS_DE_SERVICO[tipo_de_servico]
  end
  
  private
  TIPOS_DE_DEFEITO =
  {
    1 => 'Erro de operação',
    2 => 'Abuso de utilização',
    3 => 'Falha de componente',
    4 => 'Outro'
  } 
  TIPOS_DE_SERVICO =
  {
    1 => 'Instalação',
    2 => 'Calibração',
    3 => 'Manutenção preventiva',
    4 => 'Manutenção corretiva'
  }
  
  def atribui_data
    self.data_abertura = Date.today
  end
  
  
end
