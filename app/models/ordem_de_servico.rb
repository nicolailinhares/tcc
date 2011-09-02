class OrdemDeServico
  include MongoMapper::Document

  key :data_abertura, Date
  key :data_fechamento, Date
  key :custo_peca, Float
  key :custo_mao_de_obra, Float
  key :custo_frete, Float
  key :tipo_servico, Integer
  key :manutencao_interna, Boolean
  key :tipo_defeito, Integer
  key :descricao_falha, String
  key :descricao_solucao, String

end
