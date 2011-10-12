class Usuario
  include MongoMapper::Document
  
  devise :database_authenticatable, :registerable, :rememberable, :trackable
  
  key :nome, String
  key :telefone, String
  key :nivel, Integer
  key :email, String
  key :setores_ids, Array
  
  Usuario.ensure_index :email, :unique => true
  
  many :ordens_de_servico, :as => :ordenado
  many :notificacoes
  
  validates_length_of :nome, :minimum => 5, :message => 'no mínimo 5 caracteres'
  
  validates_uniqueness_of :email, :case_sensitive => false, :allow_blank => false, :message => 'já está em uso'
  validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, :allow_blank => false, :message => 'formato inválido'

  validates_presence_of :password, :message => 'não pode estar em branco'
  validates_confirmation_of :password, :message => 'não confere com a confirmação.'

  validates_length_of :password, :within => 6..30, :allow_blank => true, :message => 'deve possuir entre 6 e 30 caracteres.'
  
  def self.texto_nivel n
    NIVEIS[n]
  end
  
  def self.niveis
    NIVEIS.to_a.sort
  end
  
   def nome_nivel
    NIVEIS[nivel]
  end
  
  private
  NIVEIS =
  {
    1 => 'Profissional de saúde',
    2 => 'Técnico',
    3 => 'Gerente'
  } 
end
