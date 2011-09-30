class OrdensDeServicoController < ApplicationController
  # GET /ordens_de_servico
  # GET /ordens_de_servico.xml
  def index
    @ordens_de_servico = OrdemDeServico.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ordens_de_servico }
    end
  end

  # GET /ordens_de_servico/1
  # GET /ordens_de_servico/1.xml
  def show
    @ordem_de_servico = OrdemDeServico.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ordem_de_servico }
    end
  end

  # GET /ordens_de_servico/new
  # GET /ordens_de_servico/new.xml
  def new
    @ordem_de_servico = OrdemDeServico.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ordem_de_servico }
    end
  end

  # GET /ordens_de_servico/1/edit
  def edit
    @ordem_de_servico = OrdemDeServico.find(params[:id])
  end

  # POST /ordens_de_servico
  # POST /ordens_de_servico.xml
  def create
    @ordem_de_servico = OrdemDeServico.new(params[:ordem_de_servico])

    respond_to do |format|
      if @ordem_de_servico.save
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

    respond_to do |format|
      format.html { redirect_to(ordens_de_servico_url) }
      format.xml  { head :ok }
    end
  end
end
