# encoding: utf-8

class PermissoesController < ApplicationController

  def index
    @permissoes = Permissao.where(:instituicao_id => @instituicao.id)
    @permitidos, @pendentes = @permissoes.partition{|permissao| permissao.resolvida}
    permissoes = Permissao.where(:instituicao_id => @instituicao.id)
    @usuarios = Usuario.all - permissoes.map{|permissao| Usuario.find_by_email(permissao.email)} 
  end
  
  def pedidos
    @permissoes = Permissao.where(:usuario_id => @usuario.id, :resolvida => false)
    permissoes = Permissao.where(:usuario_id => @usuario.id)
    @instituicoes = Instituicao.all - permissoes.map{|permissao| Instituicao.find(permissao.instituicao_id)} 
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
  
  def pedido
    @permissao = Permissao.new(:usuario_id => @usuario.id, :resolvida => false)
    permissoes = Permissao.where(:usuario_id => @usuario.id)
    @instituicoes = Instituicao.all - permissoes.map{|permissao| Instituicao.find(permissao.instituicao_id)} 
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
        if @permissao.resolvida
          @usuario.registra_acao "Adicionou o usuário #{@permissao.nome_usuario} à instituicao #{Instituicao.find(@permissao.instituicao_id).nome}"
          format.html { redirect_to permissoes_path }
          format.xml  { render :xml => @permissao, :status => :created, :location => @permissao }
        else
          format.html { redirect_to :action => 'pedidos', :controller => 'permissoes' }
        end
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
    @usuario.registra_acao "Desassociou o usuário #{@permissao.nome_usuario} da instituicao #{Instituicao.find(@permissao.instituicao_id).nome}"
    respond_to do |format|
      format.html { redirect_to(permissoes_url) }
      format.xml  { head :ok }
    end
  end
  
end
