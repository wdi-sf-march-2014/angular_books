AngularBook::Application.routes.draw do

  root 'pages#index'
  resources :books, except: [:new, :edit]
  get 'books_templates/index', to: "books_templates#index"
  get 'books_templates/show', to: "books_templates#show"
  get 'books_templates/new', to: "books_templates#new"
  get 'books_templates/edit', to: "books_templates#edit"
end
