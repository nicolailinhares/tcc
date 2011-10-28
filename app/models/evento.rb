# encoding: utf-8

class Evento < Validacao
  include MongoMapper::EmbeddedDocument

  key :data, Date
  key :tipo, Integer
  key :frequencia, Integer, :default => nil
  key :setor_id, ObjectId
  key :instituicao_id, ObjectId
  key :item_id, ObjectId
  key :encaminhado, Boolean, :default => false
  
  attr_accessor :pai
  
  def valida pai
    self.superpai = pai
    valida_presenca_de :data
  end
  
  def nome_tipo
    TIPOS[tipo]
  end
  
  def cor
    CORES[tipo]
  end
  
  def titulo_evento
    nome_tipo + '. Item ' + get_item.patrimonio + '.'
  end
  
  def get_item
    item = Instituicao.find(instituicao_id).setores.find(setor_id).itens.find(item_id)
  end
  
  #######
  #estaticos
  ######
  
  def self.tipos
    TIPOS.to_a.sort
  end
  
  def self.retorna_eventos tipo, instituicao, setor = nil, item = nil 
    if setor.nil?
      eventos = Instituicao.find(instituicao).eventos.select{|evento| evento.encaminhado == false  and evento.data > (Date.today - 5)}
    elsif item.nil?
      eventos = Instituicao.find(instituicao).eventos.select{|evento| evento.setor_id == setor and evento.encaminhado == false and evento.data > (Date.today - 5)}
    else
      eventos = Instituicao.find(instituicao).eventos.select{|evento| evento.item_id == item and evento.setor_id == setor and evento.encaminhado == false  and evento.data > (Date.today - 5)}
    end
  end
  
  def self.calendario instituicao
    eventos_arr = []
    eventos = Instituicao.find(instituicao).eventos
    eventos.each do |evento|
    
      eventos_arr << {:title => evento.titulo_evento, :start => evento.data, :color => evento.cor,
      :url => "/instituicoes/#{evento.instituicao_id}/setores/#{evento.setor_id}/itens/#{evento.item_id}"}
    end
    return eventos_arr
  end
  
  private
  TIPOS = {
    1 => 'Manutenção preventiva',
    2 => 'Calibração',
    3 => 'Vencimento garantia',
    4 => 'Aquisição de equipamento'
  }
  
  CORES = {
    1 => 'darkBlue',
    2 => 'blue',
    3 => 'red',
    4 => 'green'
  }
end
