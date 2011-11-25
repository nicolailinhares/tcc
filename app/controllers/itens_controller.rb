# encoding: utf-8

class ItensController < ApplicationController
  # GET /items
  # GET /items.xml
  def index
    @itens = Item.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @setor = @instituicao.setores.find(params[:setor_id])
    @item = @setor.itens.find(params[:id])
    @notificacoes = Notificacao.where(:instituicao_id => @instituicao.id, :setor_id => @setor.id, :item_id => @item.id)
    @ordens_de_servico = OrdemDeServico.where(:instituicao_id => @instituicao.id, :setor_id => @setor.id, :item_id => @item.id)
    @proximas_preventivas = Evento.retorna_eventos_por_tipo 1, @instituicao.id, @setor.id, @item.id
    #temporario
    @opcoes_status = []
    ####
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @setor = @instituicao.setores.find(params[:setor_id])
    @item = @setor.itens.build(:patrimonio => "Não edite para ser gerado")
    equipamento = @instituicao.equipamentos.first
    @marcas = @instituicao.marcas.map{|marca| [marca.nome, marca.id]}
    unless @instituicao.marcas.empty?
      modelos_disponiveis = @instituicao.marcas.first.modelos.find_all{|modelo| modelo.equipamento_id == equipamento.id}
    else
      modelos_disponiveis = []
    end
    @modelos = modelos_disponiveis.map{|modelo| [modelo.nome, modelo.id]}
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @setor = @instituicao.setores.find(params[:setor_id])
    @item = @setor.itens.find(params[:id])
    @marcas = @instituicao.marcas.map{|marca| [marca.nome, marca.id]}
    modelos_disponiveis = @instituicao.marcas.find(@item.modelo.marca_id).modelos.find_all{|modelo| modelo.equipamento_id == @item.equipamento_id}
    @modelos = modelos_disponiveis.map{|modelo| [modelo.nome, modelo.id]}
    @editando = true
    @item.data_aquisicao = @item.data_aquisicao.strftime('%d/%m/%Y')
    @item.vencimento_garantia = @item.vencimento_garantia.strftime('%d/%m/%Y')
  end

  # POST /items
  # POST /items.xml
  def create
    @setor = @instituicao.setores.find(params[:setor_id])
    unless params[:item][:data_aquisicao].empty?
      params[:item][:data_aquisicao] = Date.parse(params[:item][:data_aquisicao].to_s.gsub('/','-'))
    end
    unless params[:item][:vencimento_garantia].empty? 
      params[:item][:vencimento_garantia] = Date.parse(params[:item][:vencimento_garantia].to_s.gsub('/','-'))
    end 
    @item = @setor.itens.build(params[:item])
    unless (params[:marca_id].nil? or params[:modelo_id].nil?)
      @item.modelo = @instituicao.marcas.find(params[:marca_id]).modelos.find(params[:modelo_id])
    end 
    if @item.patrimonio == 'Não edite para ser gerado' and !params[:item][:equipamento_id].nil?
      @item.patrimonio = Item.gera_patrimonio(@instituicao,@setor,@item)
    end
    @instituicao.eventos.build(:tipo => 3, :data => @item.vencimento_garantia, :setor_id => @setor.id, :item_id => @item.id, :instituicao_id => @instituicao.id)
    @instituicao.eventos.build(:tipo => 4, :data => @item.data_aquisicao, :setor_id => @setor.id, :item_id => @item.id, :instituicao_id => @instituicao.id)
    respond_to do |format|
      if @instituicao.save
        @usuario.registra_acao "Criou o item #{@item.patrimonio} no setor #{@setor.nome}"
        @setor.afixa_avisos @item.status, "O item <a href='"+instituicao_setor_item_path(@instituicao.id,@setor.id,@item.id)+"'>#{@item.patrimonio}</a> foi criado", @instituicao.id
        format.html { redirect_to(instituicao_setor_path(@instituicao.id,@setor.id), :notice => 'Item criado com sucesso.') }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        prepara_item
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @setor = @instituicao.setores.find(params[:setor_id])
    @item = @setor.itens.find(params[:id])
    params[:item][:data_aquisicao] = Date.parse(params[:item][:data_aquisicao].to_s.gsub('/','-'))
    params[:item][:vencimento_garantia] = Date.parse(params[:item][:vencimento_garantia].to_s.gsub('/','-'))
    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to(instituicao_setor_path(@instituicao.id,@setor.id), :notice => 'Item atualizado com sucesso.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def busca
    termo = params[:patrimonio]
    encontrado = nil
    setor_id = nil
    @instituicao.setores.each do |setor|
      setor_id = setor.id
      setor.itens.each do |item|
        if item.patrimonio == termo
          encontrado = item
          break
        end
      end
    end
    if encontrado.nil?
      unless params[:setor_id].nil?
        redirect_to instituicao_setor_path(@instituicao.id,params[:setor_id]), :notice => "Item não encontrado"
      else  
        redirect_to instituicao_path(@instituicao.id), :notice => "Item não encontrado"
      end
    else
      redirect_to instituicao_setor_item_path(@instituicao.id,setor_id,encontrado.id)
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @setor = @instituicao.setores.find(params[:setor_id])
    @item = @setor.find(params[:id])
    @setor.itens.delete_if{|item| item.id.to_s == params[:id]}
    @instituicao.save
    @usuario.registra_acao "Destruiu o item #{@item.patrimonio} do setor #{@setor.nome}"
    respond_to do |format|
      format.html { redirect_to(instituicao_setor_path(@instituicao.id,@setor.id)) }
      format.xml  { head :ok }
    end
  end
  
  def prepara_item
    @item = @setor.itens.build(:patrimonio => "Não edite para ser gerado")
    equipamento = @instituicao.equipamentos.first
    @marcas = @instituicao.marcas.map{|marca| [marca.nome, marca.id]}
    unless @instituicao.marcas.empty?
      modelos_disponiveis = @instituicao.marcas.first.modelos.find_all{|modelo| modelo.equipamento_id == equipamento.id}
    else
      modelos_disponiveis = []
    end
    @modelos = modelos_disponiveis.map{|modelo| [modelo.nome, modelo.id]}
  end

  
end
