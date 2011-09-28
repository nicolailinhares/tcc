class EquipeInterna
  include MongoMapper::EmbeddedDocument
  
  key :responsavel_id, ObjectId
  key :nome_responsavel, String
  key :email_responsavel, String
  key :especialidade, String
  key :ids_de_usuario, Array
  key :nome, String
  many :usuarios, :in => :ids_de_usuario
  
  many :notificacoes
 
  before_destroy :confere_se_ha_responsaveis
 
  def insere_info_responsavel instituicao
    usuario = instituicao.usuarios.find(self.responsavel_id)
    self.nome_responsavel = usuario.nome
    self.email_responsavel = usuario.email
    self.ids_de_usuario << self.responsavel_id
  end
  
  private
  def confere_se_ha_responsaveis
    if !ids_de_usuario.empty?
      return false
    end
  end
  
end
