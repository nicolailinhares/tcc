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
    #marcas_disponiveis = []
    #equipamento.ids_de_marca.each do |id|
      #marcas_disponiveis << @instituicao.marcas.find(id)
    #end
    #@marcas = marcas_disponiveis.map{|marca| [marca.nome, marca.id]}
    @marcas = @instituicao.marcas
    modelos_disponiveis = marcas_disponiveis.first.modelos.find_all{|modelo| modelo.equipamento_id == equipamento.id}
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
  end

  # POST /items
  # POST /items.xml
  def create
    @setor = @instituicao.setores.find(params[:setor_id])
    params[:item][:data_aquisicao] = Date.parse(params[:item][:data_aquisicao].to_s.gsub('/','-'))
    params[:item][:vencimento_garantia] = Date.parse(params[:item][:vencimento_garantia].to_s.gsub('/','-'))
    @item = @setor.itens.build(params[:item])
    @item.modelo = @instituicao.marcas.find(params[:marca_id]).modelos.find(params[:modelo_id])
    respond_to do |format|
      if @item.save
        format.html { redirect_to(instituicao_setor_path(@instituicao.id,@setor.id), :notice => 'Item criado com sucesso.') }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
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

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @setor = @instituicao.setores.find(params[:setor_id])
    @setor.itens.delete_if{|item| item.id.to_s == params[:id]}
    @instituicao.save
    respond_to do |format|
      format.html { redirect_to(instituicao_setor_path(@instituicao.id,@setor.id)) }
      format.xml  { head :ok }
    end
  end

  
end
