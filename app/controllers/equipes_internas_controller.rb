class EquipesInternasController < ApplicationController
  
  def criar
    equipe = @instituicao.equipes_internas.build(params[:equipe_interna])
    equipe.insere_info_responsavel @instituicao
    if @instituicao.save
      dados = {:erro => false, :especialidade => equipe.especialidade, :id => equipe.id, :nome => equipe.nome}
    else
      dados = {:erro => true}
    end
    respond_to do |format|
      format.json {render :json => dados}
    end
  end
  
  def index
    @equipes_internas = @instituicao.equipes_internas

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @equipes_internas }
    end
  end


  def show
    @equipe_interna = @instituicao.equipes_internas.find(params[:id])
    @usuarios_da_equipe = []
    usuarios_disponiveis = @instituicao.usuarios
    @equipe_interna.ids_de_usuario.each do |id|
      @usuarios_da_equipe << @instituicao.usuarios.find(id)
      usuarios_disponiveis.delete_if{|usuario| usuario.id == id}
    end
    @usuarios = usuarios_disponiveis.map{|usuario| [usuario.nome, usuario.id]}
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @equipes_internas }
    end
  end

  def new
    @equipe_interna = @instituicao.equipes_internas.build
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @equipe_interna = @instituicao.equipes_internas.find(params[:id])
  end

  # POST /usuarios
  # POST /usuarios.xml
  def create
    @equipe_interna = @instituicao.equipes_internas.build(params[:equipe_interna])
    @equipe_interna.insere_info_responsavel @instituicao
    respond_to do |format|
      if @instituicao.save
        format.html { redirect_to(instituicao_equipe_interna_path(@instituicao.id,@equipe_interna.id), :notice => 'Equipe criada com sucesso.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /usuarios/1
  # PUT /usuarios/1.xml
  def update
    @equipe_interna = @instituicao.equipes_internas.find(params[:id])
    @equipe_interna.insere_info_responsavel @instituicao
    respond_to do |format|
      if @equipe_interna.update_attributes(params[:equipe_interna])
        format.html { redirect_to(instituicao_equipes_internas_path(@instituicao.id,@equipe_interna.id), :notice => 'Equipe atualizada com sucesso.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.xml
  def destroy
    @instituicao.equipes_internas.delete_if {|equipe| equipe.id.to_s == params[:id]}
    @instituicao.save

    respond_to do |format|
      format.html { redirect_to(instituicao_equipes_internas_url) }
    end
  end
  
  
end
