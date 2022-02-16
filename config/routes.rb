Rails.application.routes.draw do
  get 'test/index'
  get 'case_coverages/index'
  get 'solution_coverages/index'
  get 'bug_coverages/index'
  get 'bugs/index'
  
#  get 'solutions/index'
  get "/solutions/", to: "solutions#index"
  get "/cases/", to: "cases#index"
#  get 'engineers/index'
#  get "/engineers/", to: "engineers#index"
#  get 'cases/index'
#  get 'case/index'
  get 'engineer_bugs', to: 'engineers#bugs'
  get 'new_comment', to: 'solutions#new_comment'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "articles#index"
  get "/stuff", to: "test#index"

#  get "/articles", to: "articles#index"
#  get "/articles/:id", to: "articles#show"
  resources :articles do
    resources :comments
  end


  resources :comments do
  end

#  get "/solution_coverages/", to: "solution_coverages#index"
#  get "/case_coverages/", to: "case_coverages#index"
#  get "/bug_coverages/", to: "bug_coverages#index"
#
#
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

end
