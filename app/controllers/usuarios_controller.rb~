# encoding: utf-8

class UsuariosController < ApplicationController
  # GET /usuarios
  # GET /usuarios.xml
  def index
    @usuarios, gerentes = @instituicao.usuarios.partition{|usuario| usuario.nivel != 3}

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @usuarios }
    end
  end

  # GET /usuarios/1
  # GET /usuarios/1.xml
  def show
    @usuario_pagina = Usuario.find(params[:usuario_id]) || @usuario
    permissoes = Permissao.where(:email => @usuario.email)
    @permissoes = permissoes.map do |permissao| 
      instituicao = Instituicao.find(permissao.instituicao_id) 
      {:nome => instituicao.nome, :cidade => instituicao.cidade, :estado => instituicao.estado,
        :instituicao => permissao.instituicao_id, :nivel => permissao.nome_nivel}
    end
    if session[:registrou].nil?
      @usuario.registra_acao 'Logou com sucesso'
      session[:registrou] = true
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @usuario }
    end
  end

  # GET /usuarios/new
  # GET /usuarios/new.xml
  def new
    @usuario = @instituicao.usuarios.build
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @usuario }
    end
  end

  # GET /usuarios/1/edit
  def edit
    @usuario = @instituicao.usuarios.find(params[:id])
  end

  # POST /usuarios
  # POST /usuarios.xml
  def create
    @usuario = @instituicao.usuarios.build(params[:usuario])

    respond_to do |format|
      if @instituicao.save
        format.html { redirect_to(instituicao_usuario_path(@instituicao.id,@usuario.id), :notice => 'Usuario criado com sucesso.') }
        format.xml  { render :xml => @usuario, :status => :created, :location => @usuario }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @usuario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /usuarios/1
  # PUT /usuarios/1.xml
  def update
    @usuario = @instituicao.usuarios.find(params[:id])

    respond_to do |format|
      if @usuario.update_attributes(params[:usuario])
        format.html { redirect_to(instituicao_usuario_path(@instituicao.id,@usuario.id), :notice => 'Usuario atualizado com sucesso.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @usuario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.xml
  def destroy
    @instituicao.usuarios.delete_if {|usuario| usuario.id.to_s == params[:id]}
    @instituicao.save

    respond_to do |format|
      format.html { redirect_to(instituicao_usuarios_url) }
      format.xml  { head :ok }
    end
  end
  
  def adicionar_ao_setor
    setor = @instituicao.setores.find(params[:setor_id])
    usuario = Usuario.find(params[:usuario_id])
    setor.ids_de_usuario << usuario.id
    usuario.setores_ids << setor.id
    if @instituicao.save
      if(params[:tipo].to_i == 1)
        dados = {:erro => false, :nome => setor.nome, :id => equipe.id}
      else
        dados = {:erro => false, :nome => usuario.nome, :id => usuario.id, :email => usuario.email}
      end
    else
      dados = {:erro => true}
    end
    respond_to do |format|
      format.json {render :json => dados}
    end
  end
  
  def remover_de_setor
    setor = @instituicao.setores.find(params[:setor_id])
    usuario = Usuario.find(params[:usuario_id])
    setor.ids_de_usuario.delete_if{|id| id == usuario.id}
    usuario.setores_ids.delete_if{|id| id == setor.id}
    if @instituicao.save
      dados = {:erro => false}
    else
      dados = {:erro => true}
    end
    respond_to do |format|
      format.json {render :json => dados}
    end
  end
  
  def opcoes_instituicao
    permissoes = Permissao.find_all_by_email(@usuario.email)
    if permissoes.empty?
      redirect_to "/#{@usuario.id}"
    elsif permissoes.length == 1
      session[:instituicao_id] = permissoes.first.instituicao_id
      session[:nivel] = permissoes.first.nivel
      redirect_to "/#{@usuario.id}"
    else
      @instituicoes = permissoes.map do |permissao| 
        instituicao = Instituicao.find(permissao.instituicao_id)
        [instituicao.nome,instituicao.id]
      end
      render :layout => 'login'
      #@instituicoes = instituicoes.map{|instituicao| [instituicao.nome, instituicao.id]}
    end
    
  end
  
  def escolhe_instituicao
    session[:instituicao_id] = params[:instituicao_id]
    permissao = Permissao.find_all_by_email(@usuario.email).detect{|p| p.instituicao_id.to_s == params[:instituicao_id]}
    session[:nivel] = permissao.nivel
    redirect_to instituicao_path(params[:instituicao_id])
  end
  
end
