class EquipesInternasController < ApplicationController
  
  def criar
    equipe = @instituicao.equipes_internas.build(params[:equipe_interna])
    if @instituicao.save
      dados = {:erro => false, :especialidade => equipe.especialidade, :id => equipe.id, :nome => equipe.nome}
    else
      dados = {:erro => true}
    end
    respond_to do |format|
      format.json {render :json => dados}
    end
  end
  
end
