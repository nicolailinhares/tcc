class PermissoesController < ApplicationController

  def index
    @permissoes = Permissao.where(:instituicao_id => @instituicao.id)
  end
  # GET /instituicoes/new
  # GET /instituicoes/new.xml
  def new
    @permissao = Permissao.new(:instituicao_id => @instituicao.id)
    permissoes = Permissao.where(:instituicao_id => @instituicao.id)
    @usuarios = Usuario.all - permissoes.map{|permissao| Usuario.find_by_email(permissao.email)} 
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @permissao }
    end
  end

  # POST /instituicoes
  # POST /instituicoes.xml
  def create
    @permissao = Permissao.new(params[:permissao])

    respond_to do |format|
      if @permissao.save
        format.html { redirect_to permissoes_path }
        format.xml  { render :xml => @permissao, :status => :created, :location => @permissao }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @permissao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /instituicoes/1
  # DELETE /instituicoes/1.xml
  def destroy
    @permissao = Permissao.find(params[:id])
    @permissao.destroy

    respond_to do |format|
      format.html { redirect_to(permissoes_url) }
      format.xml  { head :ok }
    end
  end
  
end
