# encoding: utf-8

class NotificacoesController < ApplicationController
  # GET /notificacoes
  # GET /notificacoes.xml
  def index
    @instituicao_id = params[:instituicao_id]
    @setor_id = params[:setor_id]
    @item_id = params[:item_id]
    @notificacoes = Notificacao.where(:instituicao_id => @instituicao_id, :setor_id => @setor_id, :item_id => @item_id)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @notificacoes }
    end
  end

  # GET /notificacoes/1
  # GET /notificacoes/1.xml
  def show
    @notificacao = Notificacao.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @notificacao }
    end
  end

  # GET /notificacoes/new
  # GET /notificacoes/new.xml
  def new
    @notificacao = Notificacao.new
    @notificacao.instituicao_id = params[:instituicao_id]
    @notificacao.setor_id = params[:setor_id]
    @notificacao.item_id = params[:item_id]
    @notificacao.usuario_id = @usuario.id
    @notificacao.data_abertura = Date.today
    @opcoes_status = [ ['Em funcionamento',1], ['Aguardando instalação',2], ['Aguardando manutenção corretiva',5] ]
    @selecionado = @instituicao.setores.find(params[:setor_id]).itens.find(params[:item_id]).status
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @notificacao }
    end
  end

  # GET /notificacoes/1/edit
  def edit
    @notificacao = Notificacao.find(params[:id])
    @opcoes_status = [ ['Em funcionamento',1], ['Aguardando instalação',2], ['Aguardando manutenção corretiva',5] ]
    @selecionado = @instituicao.setores.find(@notificacao.setor_id).itens.find(@notificacao.item_id).status
  end

  # POST /notificacoes
  # POST /notificacoes.xml
  def create
    @notificacao = Notificacao.new(params[:notificacao])
    setor = @instituicao.setores.find(@notificacao.setor_id)
    item = setor.itens.find(@notificacao.item_id)
    @notificacao.status_anterior = item.status
    item.status = params[:status]
    respond_to do |format|
      if @notificacao.save
        item.save
        @usuario.registra_acao "Criou o pedido de serviço #{@notificao.numero.to_s} para o item #{item.patrimonio}"
        format.html { redirect_to(@notificacao, :notice => 'Notificacao was successfully created.') }
        format.xml  { render :xml => @notificacao, :status => :created, :location => @notificacao }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @notificacao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /notificacoes/1
  # PUT /notificacoes/1.xml
  def update
    @notificacao = Notificacao.find(params[:id])

    respond_to do |format|
      if @notificacao.update_attributes(params[:notificacao])
        format.html { redirect_to(@notificacao, :notice => 'Notificacao was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @notificacao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /notificacoes/1
  # DELETE /notificacoes/1.xml
  def destroy
    @notificacao = Notificacao.find(params[:id])
    setor_id = @notificacao.setor_id
    item_id = @notificacao.item_id
    @notificacao.destroy
    @usuario.registra_acao "Destruiu o pedido de serviço #{@notificao.numero} do item #{item.patrimonio}"
    respond_to do |format|
      format.html { redirect_to("/notificacoes?instituicao_id=#{@instituicao.id}&setor_id=#{setor_id}&item_id=#{item_id}") }
      format.xml  { head :ok }
    end
  end
end
