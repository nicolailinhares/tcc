# encoding: utf-8

class Validacao
  
  def superpai=(pai)
    @superpai = pai
  end
  
  def superpai
    @superpai
  end
  
  def valida
    #Os filhos devem sobrepor esse método
  end
  
  private
  def valida_presenca_de simbolos, options = {:message => 'não está presente'}
    simbolos = Array(simbolos)
    simbolos.each do |simbolo|
      valor = self.read_attribute(simbolo)
      if valor == nil || valor == ''
        @superpai.errors.add(simbolo, options[:message])
      end
    end
  end
  
  def valida_unicidade_de simbolos, existentes, options = {:message => 'já está em uso'}
    simbolos = Array(simbolos)
    simbolos.each do |simbolo|
      busca = existentes.find_all {|x| x.read_attribute(simbolo) == self.read_attribute(simbolo)}
      if busca.length > 1
        @superpai.errors.add(simbolo,options[:message])
      end
    end
  end
  
  
end