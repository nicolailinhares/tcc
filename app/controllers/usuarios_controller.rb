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
    @usuario = @instituicao.usuarios.find(params[:id])
    @usuarios = @instituicao.usuarios
    @equipes = @instituicao.equipes_internas.map{|equipe| [equipe.nome,equipe.id]}
    @equipe_interna = @instituicao.equipes_internas.build
    @equipes_do_usuario = @usuario.equipes_ids.map{|id| @instituicao.equipes_internas.find(id)}
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
        format.html { redirect_to(instituicao_usuario_path(@instituicao.id,@usuario.id), :notice => 'Usuario was successfully created.') }
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
        format.html { redirect_to(instituicao_usuario_path(@instituicao.id,@usuario.id), :notice => 'Usuario was successfully updated.') }
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
  
  def adicionar_a_equipe
    equipe = @instituicao.equipes_internas.find(params[:equipe_id])
    usuario = @instituicao.usuarios.find(params[:usuario_id])
    unless equipe.ids_de_usuario.include? usuario.id
      equipe.ids_de_usuario << usuario.id
      usuario.equipes_ids << equipe.id
      if @instituicao.save
        if(params[:tipo].to_i == 1)
          dados = {:erro => false, :nome => equipe.nome, :especialidade => equipe.especialidade, :id => equipe.id}
        else
          dados = {:erro => false, :nome => usuario.nome, :especialidade => usuario.email, :id => usuario.id}
        end
      else
        dados = {:erro => true}
      end
    else
      dados = {:erro => true}
    end
    respond_to do |format|
      format.json {render :json => dados}
    end
  end
  
  def remover_de_equipe
    equipe = @instituicao.equipes_internas.find(params[:equipe_id])
    usuario = @instituicao.usuarios.find(params[:usuario_id])
    equipe.ids_de_usuario.delete_if{|id| id == usuario.id}
    usuario.equipes_ids.delete_if{|id| id == equipe.id}
    if @instituicao.save
      dados = {:erro => false}
    else
      dados = {:erro => true}
    end
    respond_to do |format|
      format.json {render :json => dados}
    end
  end
  
end
