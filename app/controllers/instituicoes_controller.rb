# encoding: utf-8

class InstituicoesController < ApplicationController
  # GET /instituicoes
  # GET /instituicoes.xml
  def index
    @instituicoes = Instituicao.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @instituicoes }
    end
  end

  # GET /instituicoes/1
  # GET /instituicoes/1.xml
  def show
    @instituicao = Instituicao.find(params[:id])
    @setores_do_usuario = @pCorrente.setores_ids.map{|id| @instituicao.setores.find(id)}
    @avisos = @usuario.avisos.select{|aviso| aviso.instituicao_id == @instituicao.id}
    @proximas_preventivas = Evento.retorna_eventos_por_tipo 1, @instituicao.id
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @instituicao }
    end
  end

  # GET /instituicoes/new
  # GET /instituicoes/new.xml
  def new
    @instituicao = Instituicao.new
    @cidades = []
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @instituicao }
    end
  end

  # GET /instituicoes/1/edit
  def edit
    @instituicao = Instituicao.find(params[:id])
    @cidades = Estado.where(:sigla => @instituicao.estado).first.cidades || []
  end

  # POST /instituicoes
  # POST /instituicoes.xml
  def create
    @instituicao = Instituicao.new(params[:instituicao])
    
    respond_to do |format|
      if @instituicao.save
        @usuario.registra_acao "Criou a instituição #{@instituicao.nome}"
        session[:instituicao_id] = @instituicao.id
        format.html { redirect_to "/#{@usuario.id}" }
        format.xml  { render :xml => @instituicao, :status => :created, :location => @instituicao }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @instituicao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /instituicoes/1
  # PUT /instituicoes/1.xml
  def update
    @instituicao = Instituicao.find(params[:id])

    respond_to do |format|
      if @instituicao.update_attributes(params[:instituicao])
        format.html { redirect_to(@instituicao, :notice => 'Instituição criada com sucesso.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @instituicao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /instituicoes/1
  # DELETE /instituicoes/1.xml
  def destroy
    @instituicao = Instituicao.find(params[:id])
    @instituicao.destroy
    @usuario.registra_acao "Destruiu a instituição #{@instituicao.nome}"
    respond_to do |format|
      format.html { redirect_to(instituicoes_url) }
      format.xml  { head :ok }
    end
  end
  
  def redireciona
    redirect_to '/instituicoes'
  end
  
    
  def retorna_cidades
    cidades = Estado.where(:sigla => params[:estado]).first.cidades
    select = {:data => ''};
    cidades.each do |cidade|
      select[:data] += "<option value='#{cidade.nome}'>#{cidade.nome}</option>"
    end
    respond_to do |format|
      format.json {render :json => select}
    end
  end
  
  def base_dados
    @equipamentos = @instituicao.equipamentos
    @marcas = @instituicao.marcas
    respond_to do |format|
      format.html # show.html.erb
    end
  end
  
  def agenda
  
  end
  
end
