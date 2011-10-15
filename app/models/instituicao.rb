class Instituicao
  include MongoMapper::Document

  key :numero_leitos, Integer
  key :nome, String
  key :endereco, String
  key :bairro, String
  key :cidade, String
  key :complemento, String
  key :estado, String
  key :criador_id, ObjectId
  
  many :permissoes
  many :setores
  many :equipes_internas
  many :marcas
  many :equipamentos
  validate :valida_filhos
  after_create :cria_permissao_gerente
  
  private
  def cria_permissao_gerente
    usuario = Usuario.find(criador_id)
    permissao = Permissao.new(:usuario_id => usuario.id, :email => usuario.email, :instituicao_id => id, :nivel => 3)
    permissao.save
  end
  
  def valida_filhos
    setores.each do |setor|
      setor.valida self
      return if errors.any?
      setor.itens.each do |item|
        item.valida setor
        return if errors.any?
      end
      setor.salas.each do |sala|
        sala.valida setor
        return if errors.any?
      end
    end
    marcas.each do |marca|
      marca.valida self
      return if errors.any?
    end
    equipamentos.each do |equipamento|
      equipamento.valida self
      return if errors.any?
    end
  end
end
