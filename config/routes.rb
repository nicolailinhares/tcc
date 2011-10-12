Tcc::Application.routes.draw do
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

  root :to => 'usuarios#opcoes_instituicao'

  match 'instituicoes/retorna_cidades' => 'instituicoes#retorna_cidades'
  match 'equipes_internas/criar' => 'equipes_internas#criar', :via => :post
  
  match 'usuarios/adicionar_a_equipe' => 'usuarios#adicionar_a_equipe', :via => :post
  match 'usuarios/remover_de_equipe' => 'usuarios#remover_de_equipe', :via => :post
  match 'usuarios/opcoes_instituicao' => 'usuarios#opcoes_instituicao'
  match 'usuarios/escolhe_instituicao' => 'usuarios#escolhe_instituicao', :via => :post
  
  match 'salas/insercao_de_item' => 'salas#insercao_de_item'
  match 'salas/inserir_item' => 'salas#inserir_item'
  
  match 'ajax/criar_equipamento' => 'ajax#criar_equipamento', :via => :post
  match 'ajax/criar_marca' => 'ajax#criar_marca', :via => :post
  match 'ajax/criar_modelo' => 'ajax#criar_modelo', :via => :post
  match 'ajax/busca_modelos' => 'ajax#busca_modelos', :via => :post
  

  devise_for :usuarios, :controllers => {:sessions=>"sessions", :registrations => 'registrations' },
              :path_names => {
                :sign_up => "registrar",
                :sign_out => "sair",
                :sign_in => "entrar",
                :edit => "editar",
                :password => "senha"
  }
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
