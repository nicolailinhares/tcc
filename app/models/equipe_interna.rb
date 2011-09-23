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
end
