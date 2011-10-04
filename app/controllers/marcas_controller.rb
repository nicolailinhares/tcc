class MarcasController < ApplicationController
  # GET /setores
  # GET /setores.xml
  def index
    @marcas = @instituicao.marcas

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @setores }
    end
  end

  # GET /setores/1
  # GET /setores/1.xml
  def show
    @marca = @instituicao.marcas.find(params[:id])
    @modelos = @marca.modelos
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @setor }
    end
  end

  # GET /setores/new
  # GET /setores/new.xml
  def new
    @marca = @instituicao.marcas.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @setor }
    end
  end

  # GET /setores/1/edit
  def edit
    @marca = @instituicao.marcas.find(params[:id])
  end

  # POST /setores
  # POST /setores.xml
  def create
    @marca = @instituicao.marcas.build(params[:marca])

    respond_to do |format|
      if @instituicao.save
        format.html { redirect_to(instituicao_marca_path(@instituicao.id,@marca.id), :notice => 'Marca criada com sucesso.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /setores/1
  # PUT /setores/1.xml
  def update
    @marca = @instituicao.marcas.find(params[:id])

    respond_to do |format|
      if @marca.update_attributes(params[:setor])
        format.html { redirect_to(instituicao_marca_path(@instituicao.id,@marca.id), :notice => 'Marca atualizada com sucesso.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /setores/1
  # DELETE /setores/1.xml
  def destroy
    @instituicao.marcas.delete_if{|marca| marca.id.to_s == params[:id]}
    @instituicao.equipamentos.each do |equipamento|
      equipamento.ids_de_marca.delete_if {|id| id == params[:id]}
    end
    @instituicao.save

    respond_to do |format|
      format.html { redirect_to(instituicao_marcas_url) }
      format.xml  { head :ok }
    end
  end
end
