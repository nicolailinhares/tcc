class Usuario
  include MongoMapper::EmbeddedDocument

  key :nome, String
  key :telefone, String
  key :nivel, Integer
  
  many :ordens_de_servico, :as => :ordenado
  many :notificacoes
  
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
