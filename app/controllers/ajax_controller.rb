class AjaxController < ApplicationController
  
  def criar_equipamento
    equipamento = @instituicao.equipamentos.build(params[:equipamento])
    if equipamento.save
      resposta = {:erro => false, :nome => equipamento.nome, :id => equipamento.id}
    else
      resposta = {:erro => true}
    end
    responde resposta 
  end
  
  def criar_marca
    marca = @instituicao.marcas.build(params[:marca])
    if marca.save
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
      resposta = {:erro => false, :nome => modelo.nome, :id => modelo.id}
    else
      resposta = {:erro => true}
    end
    responde resposta 
  end
  
  private
  def responde resposta
    respond_to do |format|
      format.json {render :json => resposta}
    end
  end
  
end