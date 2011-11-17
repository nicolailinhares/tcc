# encoding: utf-8
class CentralDeDados
  
  def self.dados_situacao params
    instituicao = Instituicao.find(params[:instituicao])
    dados = {1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0}
    instituicao.setores.each do |setor|
      setor.itens.each do |item|
        dados[item.status] += 1
      end
    end
    dados = dados.to_a
    dados.each do |dado|
      dado[0] = Item.texto_status dado[0]
    end
    return dados
  end
  
  def self.dados_custos params
    instituicao = Instituicao.find(params[:instituicao])
    datas,eixo = CentralDeDados.configura_datas
    dados = {1 => [0,0,0], 2 => [0,0,0], 3 => [0,0,0], 4 => [0,0,0]}
    os = OrdemDeServico.where(:instituicao_id => instituicao.id)
    interessantes,restante = os.partition{|ordem| !ordem.data_fechamento.nil?}
    interessantes.each do |ordem|
      datas.each_pair do |key,value|
        if ordem.data_fechamento.month == value
          dados[1][key] += ordem.custo_mao_de_obra
          dados[2][key] += ordem.custo_frete
          dados[3][key] += ordem.custo_peca
          dados[4][key] += ordem.custo_total
        end
      end
    end
    dados = dados.to_a
    dados.each do |dado|
      dado[0] = NOMES_CUSTOS[dado[0]]
      dado.flatten!
    end
    return {:eixo => eixo, :dados => dados}
  end
  
  def self.dados_servicos params
    instituicao = Instituicao.find(params[:instituicao])
    datas,eixo = CentralDeDados.configura_datas
    dados = {1 => [0,0,0], 2 => [0,0,0], 3 => [0,0,0], 4 => [0,0,0]}
    os = OrdemDeServico.where(:instituicao_id => instituicao.id)
    ps = Notificacao.where(:instituicao_id => instituicao.id)
    fechadas,abertas = os.partition{|ordem| !ordem.data_fechamento.nil?}
    despachados,abertos = ps.partition{|pedido| pedido.despachada}
    datas.each_pair do |key,value|
      os.each do |ordem|
        if ordem.data_abertura.month == value
          dados[1][key] += 1
        end
      end
      fechadas.each do |ordem|
        if ordem.data_fechamento.month == value
          dados[2][key] += 1
        end
      end
      ps.each do |pedido|
        if pedido.data_abertura.month == value
          dados[3][key] += 1
        end
      end
      despachados.each do |pedido|
        if pedido.data_despacho.month == value
          dados[4][key] += 1
        end
      end          
    end
    dados = dados.to_a
    dados.each do |dado|
      dado[0] = NOMES_SERVICOS[dado[0]]
      dado.flatten!
    end
    return {:eixo => eixo, :dados => dados}
  end
  
  def self.dados_tempo params
    instituicao = Instituicao.find(params[:instituicao])
    datas,eixo = CentralDeDados.configura_datas
    dados = {1 => [0,0,0], 2 => [0,0,0]}
    acumulado = [0,0]
    os = OrdemDeServico.where(:instituicao_id => instituicao.id)
    ps = Notificacao.where(:instituicao_id => instituicao.id)
    fechadas,abertas = os.partition{|ordem| !ordem.data_fechamento.nil?}
    despachados,abertos = ps.partition{|pedido| pedido.despachada}
    datas.each_pair do |key,value|
      fechadas.each do |ordem|
        if ordem.data_abertura.month == value
          dados[1][key] += ordem.data_fechamento - ordem.data_abertura
          acumulado[0] += 1
        end
      end
      despachados.each do |pedido|
        if pedido.data_despacho.month == value
          dados[2][key] += ordem.data_despacho - ordem.data_abertura
          acumulado[1] += 1
        end
      end          
    end
    if acumulado[0] > 0
      dados[1][0] = (dados[1][0]/acumulado[0]).to_i 
      dados[1][1] = (dados[1][1]/acumulado[0]).to_i
      dados[1][2] = (dados[1][2]/acumulado[0]).to_i
    end
    if acumulado[1] > 0
      dados[2][0] = (dados[2][0]/acumulado[1]).to_i
      dados[2][1] = (dados[2][1]/acumulado[1]).to_i
      dados[2][2] = (dados[2][1]/acumulado[1]).to_i
    end 
    dados = dados.to_a
    dados.each do |dado|
      dado[0] = NOMES_TEMPO[dado[0]]
      dado.flatten!
    end
    return {:eixo => eixo, :dados => dados}
  end
  
  def self.configura_datas
    base = Date.today
    datas = {0 => (base.prev_month.month - 1), 1 => base.prev_month.month, 2 => base.month}
    eixo = [NOMES_MESES[datas[0]],NOMES_MESES[datas[1]],NOMES_MESES[datas[2]]]
    return [datas,eixo]
  end
  
  private
  NOMES_CUSTOS = 
  {
    1 => 'Custo com mão-de-obra',
    2 => 'Custo com frete',
    3 => 'Custo com peças',
    4 => 'Custo total'
  }
  
  NOMES_MESES = 
  {
    1 => 'Janerio',
    2 => 'Fevereiro',
    3 => 'Março',
    4 => 'Abril',
    5 => 'Maio',
    6 => 'Junho',
    7 => 'Julho',
    8 => 'Agosto',
    9 => 'Setembro',
    10 => 'Outubro',
    11 => 'Novembro',
    12 => 'Dezembro'
  }
  
  NOMES_SERVICOS =
  {
    1 => 'Ordens de serviço abertas',
    2 => 'Ordens de serviço concluídas',
    3 => 'Pedidos de serviço abertos',
    4 => 'Pedidos de serviço encaminhados'
  }
  
  NOMES_TEMPO =
  {
    1 => 'Ordem de serviço',
    2 => 'Pedido de serviço'
  }

end
