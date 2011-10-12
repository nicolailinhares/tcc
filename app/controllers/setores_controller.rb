class SetoresController < ApplicationController
  # GET /setores
  # GET /setores.xml
  def index
    @setores = @instituicao.setores

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @setores }
    end
  end

  # GET /setores/1
  # GET /setores/1.xml
  def show
    @setor = @instituicao.setores.find(params[:id])
    @salas = @setor.salas
    @itens = @setor.itens
    @usuarios_do_setor = @setor.ids_de_usuario.map{|id| Usuario.find(id)}
    usuarios_total = Permissao.find_all_by_instituicao_id(@instituicao.id).map{|permissao| Usuario.find_by_email(permissao.email)}
    usuarios_disponiveis = usuarios_total - @usuarios_do_setor
    @usuarios = usuarios_disponiveis.map{|usuario| [usuario.nome, usuario.id]}
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @setor }
    end
  end

  # GET /setores/new
  # GET /setores/new.xml
  def new
    @setor = @instituicao.setores.build(:endereco => @instituicao.endereco, :bairro => @instituicao.bairro, :cidade => @instituicao.cidade, :estado => @instituicao.estado)
    @usuairos = Permissao.find_all_by_instituicao_id(@instituicao.id).map{|permissao| Usuario.find_by_email(permissao.email)}
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @setor }
    end
  end

  # GET /setores/1/edit
  def edit
    @setor = @instituicao.setores.find(params[:id])
    @usuarios = Permissao.find_all_by_instituicao_id(@instituicao.id).map{|permissao| Usuario.find_by_email(permissao.email)}
  end

  # POST /setores
  # POST /setores.xml
  def create
    @setor = @instituicao.setores.build(params[:setor])

    respond_to do |format|
      if @instituicao.save
        format.html { redirect_to(instituicao_setor_path(@instituicao.id,@setor.id), :notice => 'Setor criado com sucesso.') }
        format.xml  { render :xml => @setor, :status => :created, :location => @setor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @setor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /setores/1
  # PUT /setores/1.xml
  def update
    @setor = @instituicao.setores.find(params[:id])

    respond_to do |format|
      if @setor.update_attributes(params[:setor])
        format.html { redirect_to(instituicao_setor_path(@instituicao.id,@setor.id), :notice => 'Setor atualizado com sucesso.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @setor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /setores/1
  # DELETE /setores/1.xml
  def destroy
    @instituicao.setores.delete_if{|setor| setor.id.to_s == params[:id]}
    @instituicao.save

    respond_to do |format|
      format.html { redirect_to(instituicao_setores_url) }
      format.xml  { head :ok }
    end
  end
end
