# encoding: utf-8

class AjaxController < ApplicationController
  
  def criar_equipamento
    equipamento = @instituicao.equipamentos.build(params[:equipamento])
    if @instituicao.save
      @usuario.registra_acao "Criou o equipamento #{equipamento.nome}"
      resposta = {:erro => false, :nome => equipamento.nome, :id => equipamento.id}
    else
      resposta = {:erro => true}
    end
    responde resposta 
  end
  
  def criar_marca
    marca = @instituicao.marcas.build(params[:marca])
    if @instituicao.save
      @usuario.registra_acao "Criou a marca #{marca.nome}"
      resposta = {:erro => false, :nome => marca.nome, :id => marca.id}
    else
      resposta = {:erro => true}
    end
    responde resposta 
  end
  
  def criar_modelo
    equipamento = @instituicao.equipamentos.find(params[:modelo][:equipamento_id])
    modelo = equipamento.modelos.build(params[:modelo])
    marca = @instituicao.marcas.find(modelo.marca_id)
    modelo.nome_marca = marca.nome
    marca.modelos << modelo
    equipamento.ids_de_marca << marca.id unless equipamento.ids_de_marca.include? marca.id
    if @instituicao.save
      @usuario.registra_acao "Criou o modelo #{modelo.nome} na marca #{marca.nome} para o equipamento #{equipamento.nome}"
      resposta = {:erro => false, :nome => modelo.nome, :id => modelo.id}
    else
      resposta = {:erro => true}
    end
    responde resposta 
  end
  
  def busca_modelos
    equipamento_id = params[:equipamento_id]
    marca_id = params[:marca_id]
    marca = @instituicao.marcas.find(marca_id)
    modelos_disponiveis = marca.modelos.find_all{|modelo| modelo.equipamento_id.to_s == equipamento_id}
    
    if modelos_disponiveis.empty?
      select = {:erro => true}
    else
      select = {:erro => false, :data => ''}
      modelos_disponiveis.each do |modelo|
        select[:data] += "<option value='#{modelo.id}'>#{modelo.nome}</option>"
      end
    end
    respond_to do |format|
      format.json {render :json => select}
    end
  end
  
  def cancela_pedido
    pedido = Notificacao.find(params[:id])
    pedido.motivo_cancelamento = params[:motivo]
    pedido.tipo_despacho = 2
    pedido.despachada = true
    pedido.data_despacho = Date.today
    setor = @instituicao.setores.find(pedido.setor_id) 
    item = setor.itens.find(pedido.item_id)
    item.status = pedido.status_anterior
    if pedido.save
      item.save
      @usuario.registra_acao "Cancelou o pedido de serviço #{pedido.numero} do item #{item.patrimonio}"
      setor.afixa_avisos item.status, "O pedido de serviço <a href='"+notificacao_path(pedido.id)+"'>#{pedido.numero}</a> foi cancelado", @instituicao.id
      responde({:erro => false})
    else
      responde({:erro => true})
    end
  end
  
  def conclui_os
    os = OrdemDeServico.find(params[:id])
    os.custo_peca = params[:custo_peca]
    os.custo_frete = params[:custo_frete]
    os.custo_mao_de_obra = params[:custo_mao]
    os.descricao_solucao = params[:descricao_solucao]
    os.data_fechamento = Date.today
    setor = @instituicao.setores.find(os.setor_id)
    item = setor.itens.find(os.item_id)
    item.status = params[:status]
    if os.save
      item.save
      @usuario.registra_acao "Concluiu a ordem de serviço #{os.numero} do item #{item.patrimonio}"
      setor.afixa_avisos item.status, "A ordem de serviço <a href='"+ordem_de_servico_path(os.id)+"'>#{os.numero}</a> foi concluída", @instituicao.id
      responde({:erro => false})
    else
      responde({:erro => true})
    end
  end
  
  def transforma_em_os
    pedido = Notificacao.find(params[:id])
    setor = @instituicao.setores.find(pedido.setor_id) 
    item = setor.itens.find(pedido.item_id)
    os = OrdemDeServico.new(:descricao_falha => pedido.descricao_falha, 
        :tipo_de_servico => params[:tipo_servico], :tipo_de_defeito => params[:tipo_servico],
        :manutencao_interna => params[:interna], :item_id => item.id, :setor_id => setor.id, :instituicao_id => @instituicao.id)
    item.status = params[:tipo_servico]
    pedido.tipo_despacho = 1
    pedido.despachada = true
    pedido.data_despacho = Date.today
    if os.save
      item.save
      pedido.save
      setor.afixa_avisos item.status, "Para o pedido de serviço <a href='"+notificacao_path(pedido.id)+"'>#{pedido.numero}</a>, foi aberta a ordem de serviço <a href='"+ordem_de_servico_path(os.id)+"'>#{os.numero}</a>", @instituicao.id
      responde({:erro => false, :id_os => os.id})
    else
      responde({:erro => true})
    end
    
  end
  
  def agendar_evento
    evento = Evento.new(params[:evento])
    @instituicao.eventos << evento
    if @instituicao.save
      responde({:erro => false})
    else
      responde({:erro => true})
    end
  end
  
  def retorna_eventos
    eventos = Evento.calendario @instituicao.id
    responde eventos
  end
  
  def aceitar_usuario
    permissao = Permissao.find(params[:permissao_id])
    permissao.nivel = params[:nivel]
    permissao.resolvida = true
    if permissao.save
      responde({:erro => false})
    else
      responde({:erro => true})
    end
  end
  
  private
  def responde resposta
    respond_to do |format|
      format.json {render :json => resposta}
    end
  end

end
