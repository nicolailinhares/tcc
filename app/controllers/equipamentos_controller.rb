# encoding: utf-8

class EquipamentosController < ApplicationController
  # GET /equipamentos
  # GET /equipamentos.xml
  def index
    @equipamentos = @instituicao.equipamentos

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @equipamentos }
    end
  end

  # GET /equipamentos/1
  # GET /equipamentos/1.xml
  def show
    @equipamento = @instituicao.equipamentos.find(params[:id])
    @modelos = @equipamento.modelos
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @equipamento }
    end
  end

  # GET /equipamentos/new
  # GET /equipamentos/new.xml
  def new
    @equipamento = @instituicao.equipamentos.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @equipamento }
    end
  end

  # GET /equipamentos/1/edit
  def edit
    @equipamento = @instituicao.equipamentos.find(params[:id])
  end

  # POST /equipamentos
  # POST /equipamentos.xml
  def create
    @equipamento = @instituicao.equipamentos.build(params[:equipamento])

    respond_to do |format|
      if @instituicao.save
        format.html { redirect_to(instituicao_equipamento_path(@instituicao.id,@equipamento.id), :notice => 'Equipamento criado com sucesso.') }
        format.xml  { render :xml => @equipamento, :status => :created, :location => @equipamento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @equipamento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /equipamentos/1
  # PUT /equipamentos/1.xml
  def update
    @equipamento = @instituicao.equipamentos.find(params[:id])

    respond_to do |format|
      if @equipamento.update_attributes(params[:equipamento])
        format.html { redirect_to(instituicao_equipamento_path(@instituicao.id,@equipamento.id), :notice => 'Equipamento atualizado com sucesso.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @equipamento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /equipamentos/1
  # DELETE /equipamentos/1.xml
  def destroy
    @instituicao.equipamentos.delete_if{|equipamento| equipamento.id.to_s == params[:id]}
    @instituicao.save

    respond_to do |format|
      format.html { redirect_to(instituicao_equipamentos_url) }
      format.xml  { head :ok }
    end
  end
end
