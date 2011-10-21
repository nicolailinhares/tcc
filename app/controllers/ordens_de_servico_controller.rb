# encoding: utf-8

class OrdensDeServicoController < ApplicationController
  # GET /ordens_de_servico
  # GET /ordens_de_servico.xml
  def index
    @setor_id = params[:setor_id]
    @item_id = params[:item_id]
    @ordens_de_servico = OrdemDeServico.where(:instituicao_id => @instituicao.id, :setor_id => @setor_id, :item_id => @item_id)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ordens_de_servico }
    end
  end

  # GET /ordens_de_servico/1
  # GET /ordens_de_servico/1.xml
  def show
    @ordem_de_servico = OrdemDeServico.find(params[:id])
    @opcoes_status = [ ['Em funcionamento',1], ['Aguardando instalação',2], ['Aguardando manutenção corretiva',5] ]
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ordem_de_servico }
    end
  end

  # GET /ordens_de_servico/new
  # GET /ordens_de_servico/new.xml
  def new
    @ordem_de_servico = OrdemDeServico.new
    @ordem_de_servico.instituicao_id = @instituicao.id
    @ordem_de_servico.setor_id = params[:setor_id]
    @ordem_de_servico.item_id = params[:item_id]
    @ordem_de_servico.usuario_id = @usuario.id
    @ordem_de_servico.data_abertura = Date.today
    @opcoes_status = [ ['Em funcionamento',1], ['Aguardando instalação',2], ['Aguardando manutenção corretiva',5] ]
    @selecionado = @instituicao.setores.find(params[:setor_id]).itens.find(params[:item_id]).status
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ordem_de_servico }
    end
  end

  # GET /ordens_de_servico/1/edit
  def edit
    @ordem_de_servico = OrdemDeServico.find(params[:id])
    @opcoes_status = [ ['Em funcionamento',1], ['Aguardando instalação',2], ['Aguardando manutenção corretiva',5] ]
    @selecionado = @instituicao.setores.find(@ordem_de_servico.setor_id).itens.find(@ordem_de_servico.item_id).status
  end

  # POST /ordens_de_servico
  # POST /ordens_de_servico.xml
  def create
    @ordem_de_servico = OrdemDeServico.new(params[:ordem_de_servico])
    setor = @instituicao.setores.find(@ordem_de_servico.setor_id)
    item = setor.itens.find(@ordem_de_servico.item_id)
    item.status = params[:status]
    respond_to do |format|
      if @ordem_de_servico.save
        item.save
        @usuario.registra_acao "Criou a ordem de serviço #{@ordem_de_servico.numero.to_s} para o item #{item.patrimonio}"
        format.html { redirect_to(@ordem_de_servico, :notice => 'Ordem de serviço criada com sucesso.') }
        format.xml  { render :xml => @ordem_de_servico, :status => :created, :location => @ordem_de_servico }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ordem_de_servico.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ordens_de_servico/1
  # PUT /ordens_de_servico/1.xml
  def update
    @ordem_de_servico = OrdemDeServico.find(params[:id])

    respond_to do |format|
      if @ordem_de_servico.update_attributes(params[:ordem_de_servico])
        format.html { redirect_to(@ordem_de_servico, :notice => 'Ordem de serviço atualizada com sucesso.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ordem_de_servico.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ordens_de_servico/1
  # DELETE /ordens_de_servico/1.xml
  def destroy
    @ordem_de_servico = OrdemDeServico.find(params[:id])
    @ordem_de_servico.destroy
    @usuario.registra_acao "Destruiu a ordem de serviço #{@notificao.numero}  do item #{item.patrimonio}"
    respond_to do |format|
      format.html { redirect_to(ordens_de_servico_url) }
      format.xml  { head :ok }
    end
  end
end
