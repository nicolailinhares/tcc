# encoding: utf-8

class ModelosController < ApplicationController
  # GET /modelos
  # GET /modelos.xml
  def index
    @modelos = Modelo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @modelos }
    end
  end

  # GET /modelos/1
  # GET /modelos/1.xml
  def show
    @equipamento = @instituicao.equipamentos.find(params[:equipamento_id])
    @modelo = @equipamento.modelos.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @modelo }
    end
  end

  # GET /modelos/new
  # GET /modelos/new.xml
  def new
    @equipamento = @instituicao.equipamentos.find(params[:equipamento_id])
    @modelo = @equipamento.modelos.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @modelo }
    end
  end

  # GET /modelos/1/edit
  def edit
    @equipamento = @instituicao.equipamentos.find(params[:equipamento_id])
    @modelo = @equipamento.modelos.find(params[:id])
  end

  # POST /modelos
  # POST /modelos.xml
  def create
    @equipamento = @instituicao.equipamentos.find(params[:equipamento_id])
    @modelo = @equipamento.modelos.build(params[:modelo])
    marca = @instituicao.marcas.find(@modelo.marca_id)
    @modelo.nome_marca = marca.nome
    @modelo.nome_equipamento = @equipamento.nome
    marca.modelos << @modelo
    @equipamento.ids_de_marca << marca.id unless @equipamento.ids_de_marca.include? marca.id
    respond_to do |format|
      if @instituicao.save
        @usuario.registra_acao "Criou o modelo #{@modelo.nome} da marca #{@modelo.nome_marca} no equipamento #{@equipamento.nome} com sucesso"
        format.html { redirect_to(instituicao_equipamento_modelo_path(@instituicao.id,@equipamento.id,@modelo.id), :notice => 'Modelo criado com sucesso.') }
        format.xml  { render :xml => @modelo, :status => :created, :location => @modelo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @modelo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /modelos/1
  # PUT /modelos/1.xml
  def update
    @equipamento = @instituicao.equipamentos.find(params[:equipamento_id])
    @modelo = @equipamento.modelos.find(params[:id])
    marca = @instituicao.marcas.find(@modelo.marca_id)
    @modelo.nome_marca = marca.nome
    @modelo.nome_equipamento = @equipamento.nome
    respond_to do |format|
      if @modelo.update_attributes(params[:modelo])
        
        begin
          modelo_marca = marca.modelos.find(@modelo.id)
          modelo_marca.update_attributes(params[:modelo])
        rescue
          marca.modelos.build(params[:modelo])
          marca.save
        end
        format.html { redirect_to(instituicao_equipamento_modelo_path(@instituicao.id,@equipamento.id,@modelo.id), :notice => 'Modelo atualizado com sucesso.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @modelo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /modelos/1
  # DELETE /modelos/1.xml
  def destroy
    @equipamento = @instituicao.equipamentos.find(params[:equipamento_id])
    @modelo = @equipamento.modelos.find(params[:id])
    marca = @instituicao.marcas.find(@modelo.marca_id)
    @equipamento.modelos.delte_if{|modelo| modelo.id.to_s == params[:id]}
    marca.modelos.delte_if{|modelo| modelo.id.to_s == params[:id]}
    if marca.modelos.detect{|modelo| modelo.equipamento_id == @equipamento.id}.nil?
      @equipamento.ids_de_marca.delete_if {|id| id == marca.id}
    end
    @instituicao.save
    @usuario.registra_acao "Destruiu o modelo #{@modelo.nome} da marca #{@modelo.nome_marca} no equipamento #{@equipamento.nome} com sucesso"
    respond_to do |format|
      format.html { redirect_to(instituicao_equipamento_modelos_url) }
      format.xml  { head :ok }
    end
  end
end
