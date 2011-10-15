class Item < Validacao
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
  attr_accessor :pai
  #ensure_index :patrimonio, :unique => true
  many :ordens_de_servico, :as => :ordenado
  one :modelo
  
  def valida pai
    self.superpai = pai.superpai
    valida_presenca_de [:numero_serie,:patrimonio, :equipamento_id]
    valida_unicidade_de :patrimonio, pai.itens
  end
  
  def nome_status
    LISTA_DE_STATUS[status]
  end
  
  def nome_tipo_recurso
    TIPOS_DE_RECURSO[tipo_recurso]
  end
  
  def self.texto_tipo_de_recurso n
    TIPOS_DE_RECURSO[n]
  end
  
  def self.tipos_de_recurso
    TIPOS_DE_RECURSO.to_a.sort
  end
  
  def self.texto_status n
    LISTA_DE_STATUS[n]
  end
  
  def self.lista_de_status
    LISTA_DE_STATUS.to_a.sort
  end
  
  def self.gera_codigo(nome)
    codigo = ''
    nome = nome.gsub('de', '')
    nome = nome.upcase
    palavras = nome.split(' ')
    if palavras.length > 1
      codigo = palavras[0][0,1] + palavras[1][0,1]
    elsif palavras.length == 1
      codigo = palavras[0][0,2]
    end
    return codigo
  end
  
  def self.gera_numero(instituicao)
    numero = Time.now.to_i.to_s[0,12]
    numero = numero.to_s.rjust(12,'0')
    numero.insert(3,'.').insert(7,'.').insert(11,'.')
  end
  
  def self.gera_patrimonio(instituicao,setor,item)
    gera_codigo(setor.nome)+ '.' + gera_codigo(instituicao.equipamentos.find(item.equipamento_id).nome) + '/' + gera_numero(instituicao) + '-' + item.data_aquisicao.to_s[2,2]
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
