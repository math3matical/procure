Rails.application.routes.draw do
  get 'test/index'
  get 'case_coverages/index'
  get 'solution_coverages/index'
  get 'bug_coverages/index'
  get 'bugs/index'
  
  get '/test/runit', to: 'test#bugcall'
  get '/test/engineerapi', to: 'test#engineerapi'
  get '/engineers/newapi', to: 'engineers#newapi'
  get '/engineers/findapi', to: 'engineers#findapi'
  get '/cases/newapi', to: 'cases#newapi'
  get '/cases/findapi', to: 'cases#findapi'
  get '/bugs/newapi', to: 'bugs#newapi'
  get '/bugs/findapi', to: 'bugs#findapi'
  get '/solutions/horse', to: 'solutions#horse'
  get '/test/horse', to: 'test#horse'

  get "/solutions/", to: "solutions#index"
  get "/cases/", to: "cases#index"
  get 'engineer_bugs', to: 'engineers#bugs'
  get 'new_comment', to: 'solutions#new_comment'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "test#index"
  get "/stuff", to: "test#index"

  resources :articles do
    resources :comments
  end


  resources :comments do
  end

  resources :satellite_tags do
  end

  resources :provision_tags do
  end
  resources :network_tags do
  end

  resources :engineers do
    resources :bugs
    resources :cases
    resources :solutions
    resources :comments
  end

  resources :solutions do
    resources :comments
  end

  resources :solution_coverages do
    resources :comments
  end
  
  resources :bug_coverages do
    resources :comments
  end

  resources :bugs do
    resources :comments
  end

  resources :cases do
    resources :comments
  end

  resources :case_coverages do
    resources :comments
  end

  resources :engineer_tags

end
