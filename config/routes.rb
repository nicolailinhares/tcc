Tcc::Application.routes.draw do

  resources :eventos

  devise_for :usuarios, :controllers => {:sessions=>"sessions", :registrations => 'registrations' },
              :path_names => {
                :sign_up => "registrar",
                :sign_out => "sair",
                :sign_in => "entrar",
                :edit => "editar",
                :password => "senha"
  }
  match 'graficos' => 'grafico#index'
  match 'grafico/dados_situacao' => 'grafico#dados_situacao', :via => :post
  match 'grafico/dados_custos' => 'grafico#dados_custos', :via => :post
  match 'grafico/dados_servicos' => 'grafico#dados_servicos', :via => :post
  match 'grafico/dados_tempo' => 'grafico#dados_tempo', :via => :post
  match 'instituicoes/base_dados' => 'instituicoes#base_dados'
  match 'instituicoes/agenda' => 'instituicoes#agenda'
  match 'permissoes/pedidos' => 'permissoes#pedidos'
  match 'permissoes/pedido' => 'permissoes#pedido'
  resources :instituicoes do
    resources :marcas
    resources :equipes_internas
    resources :setores do
      resources :salas
      resources :itens
    end
    resources :equipamentos do
      resources :modelos
    end
  end
  
  resources :permissoes
  
  resources :ordens_de_servico

  resources :notificacoes

  root :to => 'usuarios#show'

  match 'instituicoes/retorna_cidades' => 'instituicoes#retorna_cidades'
  
  
  match 'equipes_internas/criar' => 'equipes_internas#criar', :via => :post
  
  match 'usuarios/adicionar_ao_setor' => 'usuarios#adicionar_ao_setor', :via => :post
  match 'usuarios/remover_de_setor' => 'usuarios#remover_de_setor', :via => :post
  match 'usuarios/opcoes_instituicao' => 'usuarios#opcoes_instituicao'
  match 'usuarios/escolhe_instituicao/:instituicao_id' => 'usuarios#escolhe_instituicao'
  match ':usuario_id' => 'usuarios#show'
  
  match 'salas/insercao_de_item' => 'salas#insercao_de_item'
  match 'salas/inserir_item' => 'salas#inserir_item'
  
  match 'ajax/criar_equipamento' => 'ajax#criar_equipamento', :via => :post
  match 'ajax/criar_marca' => 'ajax#criar_marca', :via => :post
  match 'ajax/criar_modelo' => 'ajax#criar_modelo', :via => :post
  match 'ajax/busca_modelos' => 'ajax#busca_modelos', :via => :post
  match 'ajax/cancela_pedido' => 'ajax#cancela_pedido', :via => :post
  match 'ajax/conclui_os' => 'ajax#conclui_os', :via => :post
  match 'ajax/transforma_em_os' => 'ajax#transforma_em_os', :via => :post
  match 'ajax/agendar_evento' => 'ajax#agendar_evento', :via => :post
  match 'ajax/retorna_eventos' => 'ajax#retorna_eventos', :via => :post
  match 'ajax/aceitar_usuario' => 'ajax#aceitar_usuario', :via => :post

  match 'itens/busca' => 'itens#busca', :via => :post
  
   
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
