class SetoresController < ApplicationController
  # GET /setores
  # GET /setores.xml
  def index
    @setores = Setor.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @setores }
    end
  end

  # GET /setores/1
  # GET /setores/1.xml
  def show
    @setor = Setor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @setor }
    end
  end

  # GET /setores/new
  # GET /setores/new.xml
  def new
    @setor = Setor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @setor }
    end
  end

  # GET /setores/1/edit
  def edit
    @setor = Setor.find(params[:id])
  end

  # POST /setores
  # POST /setores.xml
  def create
    @setor = Setor.new(params[:setor])

    respond_to do |format|
      if @setor.save
        format.html { redirect_to(@setor, :notice => 'Setor was successfully created.') }
        format.xml  { render :xml => @setor, :status => :created, :location => @setor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @setor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /setores/1
  # PUT /setores/1.xml
  def update
    @setor = Setor.find(params[:id])

    respond_to do |format|
      if @setor.update_attributes(params[:setor])
        format.html { redirect_to(@setor, :notice => 'Setor was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @setor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /setores/1
  # DELETE /setores/1.xml
  def destroy
    @setor = Setor.find(params[:id])
    @setor.destroy

    respond_to do |format|
      format.html { redirect_to(setores_url) }
      format.xml  { head :ok }
    end
  end
end
