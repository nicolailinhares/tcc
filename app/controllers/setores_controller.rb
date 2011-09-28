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
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @setor }
    end
  end

  # GET /setores/new
  # GET /setores/new.xml
  def new
    @setor = @instituicao.setores.build(:endereco => @instituicao.endereco, :bairro => @instituicao.bairro, :cidade => @instituicao.cidade, :estado => @instituicao.estado)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @setor }
    end
  end

  # GET /setores/1/edit
  def edit
    @setor = @instituicao.setores.find(params[:id])
  end

  # POST /setores
  # POST /setores.xml
  def create
    @setor = @instituicao.setores.build(params[:setor])

    respond_to do |format|
      if @instituicao.save
        format.html { redirect_to(instituicao_setor_path(@instituicao.id,@setor.id), :notice => 'Setor was successfully created.') }
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
        format.html { redirect_to(instituicao_setor_path(@instituica.id,@setor.id), :notice => 'Setor was successfully updated.') }
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
