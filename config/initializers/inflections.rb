# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format
# (all these examples are active by default):
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end
ActiveSupport::Inflector.inflections do |inflect|
  inflect.irregular 'item', 'itens'
  inflect.irregular 'setor', 'setores'
  inflect.irregular 'ordem_de_servico', 'ordens_de_servico'
  inflect.irregular 'notificacao', 'notificacoes'
  inflect.irregular 'equipe_interna', 'equipes_internas'
  inflect.irregular 'instituicao', 'instituicoes'
end