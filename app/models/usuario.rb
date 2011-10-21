# encoding: utf-8

class Usuario
  include MongoMapper::Document
  
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable
  
  key :nome, String
  key :telefone, String
  key :nivel, Integer
  key :email, String
  key :setores_ids, Array
  key :acoes, Array
  
  Usuario.ensure_index :email, :unique => true
  
  many :ordens_de_servico, :as => :ordenado
  many :notificacoes
  many :avisos
  
  before_create :registra_acao_inicial
  
  validates_length_of :nome, :minimum => 5, :message => 'no mínimo 5 caracteres'
  
  validates_uniqueness_of :email, :case_sensitive => false, :allow_blank => false, :message => 'já está em uso'
  validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, :allow_blank => false, :message => 'formato inválido'

  validates_presence_of :password, :if => :password_required?, :message => 'não pode estar em branco'
  validates_confirmation_of :password, :if => :password_required?, :message => 'não confere com a confirmação.'

  validates_length_of :password, :within => 6..30, :allow_blank => true, :message => 'deve possuir entre 6 e 30 caracteres.'
  
  def registra_acao mensagem
    at = ""
    unless @instituicao.nil?
      at = "na #{@instituicao.nome}"
    end
    self.acoes << mensagem + Time.now.strftime(' às %H:%M em %d/%m/%Y') + at + "."
    save
  end
  
  private
  def registra_acao_inicial
    self.acoes << 'Cadastrou no sistema' + Time.now.strftime('%H:%M em %d/%m/%Y')
  end
end
