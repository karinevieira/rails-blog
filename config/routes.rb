Rails.application.routes.draw do
  scope '(:locale)', locale: /pt-BR|en/ do
    root 'articles#index'
    
    resources :articles do
      resources :comments, only: [:create, :destroy]
    end
    
    resources :categories, except: [:show]
  end
end
