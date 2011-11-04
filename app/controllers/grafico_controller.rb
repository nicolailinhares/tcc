class GraficoController < ApplicationController
  def index
    if @instituicao.nil?
      redirect :back
    end
  end
  
  def dados_situacao
    dados = CentralDeDados.dados_situacao params
    responde dados
  end
  
  def dados_custos
    dados = CentralDeDados.dados_custos params
    responde dados
  end
  
  def dados_servicos
    dados = CentralDeDados.dados_servicos params
    responde dados
  end
  
  def dados_tempo
    dados = CentralDeDados.dados_tempo params
    responde dados
  end
  
  private
  def responde resposta
    respond_to do |format|
      format.json {render :json => resposta}
    end
  end

end
