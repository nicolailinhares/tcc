# encoding: utf-8

class SalasController < ApplicationController
  # GET /salas
  # GET /salas.xml
  def index
    @setor = @instituicao.setores.find(params[:setor_id])
    @salas = @setor.salas

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @salas }
    end
  end

  # GET /salas/1
  # GET /salas/1.xml
  def show
    @setor = @instituicao.setores.find(params[:setor_id])
    @sala = @setor.salas.find(params[:id])
    @itens = @sala.itens
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sala }
    end
  end

  # GET /salas/new
  # GET /salas/new.xml
  def new
    @setor = @instituicao.setores.find(params[:setor_id])
    @sala = @setor.salas.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sala }
    end
  end

  # GET /salas/1/edit
  def edit
    @setor = @instituicao.setores.find(params[:setor_id])
    @sala = @setor.salas.find(params[:id])
  end

  # POST /salas
  # POST /salas.xml
  def create
    @setor = @instituicao.setores.find(params[:setor_id])
    @sala = @setor.salas.build(params[:sala])

    respond_to do |format|
      if @instituicao.save
        @usuario.registra_acao "Criou a sala #{@sala.nome} no setor #{@setor.nome}"
        format.html { redirect_to(instituicao_setor_sala_path(@instituicao.id,@setor.id,@sala.id), :notice => 'Sala criada com sucesso.') }
        format.xml  { render :xml => @sala, :status => :created, :location => @sala }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sala.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /salas/1
  # PUT /salas/1.xml
  def update
    @setor = @instituicao.setores.find(params[:setor_id])
    @sala = @setor.salas.find(params[:id])

    respond_to do |format|
      if @sala.update_attributes(params[:sala])
        format.html { redirect_to(instituicao_setor_sala_path(@instituicao.id,@setor.id,@sala.id), :notice => 'Sala atualizada com sucesso.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sala.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /salas/1
  # DELETE /salas/1.xml
  def destroy
    @setor = @instituicao.setores.find(params[:setor_id])
    @setor.salas.delete_if{|sala| sala.id.to_s == params[:id]}
    @instituicao.save
    @usuario.registra_acao "Destruiu a sala #{@sala.nome} no setor #{@setor.nome}"
    respond_to do |format|
      format.html { redirect_to(instituicao_setor_salas_url) }
      format.xml  { head :ok }
    end
  end
  
  def insercao_de_item
    @setor = @instituicao.setores.find(params[:setor_id])
    @sala = @setor.salas.find(params[:sala_id])
    itens_disponiveis = @setor.itens.find_all{|item| item.sala_id.nil?}
    @itens = itens_disponiveis.map {|item| [item.patrimonio, item.id]}
  end
  
  def inserir_item
    @setor = @instituicao.setores.find(params[:setor_id])
    @sala = @setor.salas.find(params[:sala_id])
    @item = @setor.itens.find(params[:item_id])
    @sala.itens << @item
    @item.sala_id = @sala.id
    @instituicao.save
    @usuario.registra_acao "Moveu o item #{@item.patrimonio} para a sala #{@sala.nome} no setor #{@setor.nome}"
    redirect_to instituicao_setor_sala_path(@instituicao.id,@setor.id,@sala.id)
  end
  
end
