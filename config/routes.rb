Rails.application.routes.draw do
  get 'test/index'
  get 'bugs/index'
  
  get '/test/engineerapi', to: 'test#engineerapi'
  get '/engineers/newapi', to: 'engineers#newapi'
  get '/engineers/findapi', to: 'engineers#findapi'
  get '/cases/newapi', to: 'cases#newapi'
  get '/cases/findapi', to: 'cases#findapi'
  get '/bugs/newapi', to: 'bugs#newapi'
  get '/bugs/findapi', to: 'bugs#findapi'
  get '/solutions/newapi', to: 'solutions#newapi'
  get '/solutions/findapi', to: 'solutions#findapi'
  get '/test/horse', to: 'test#horse'
  get '/test/ocm', to: 'test#ocm'
  get '/test/attachmentdownload', to: 'test#attachmentdownload'
  get '/test/attachment_download', to: 'test#attachment_download'
  get '/test/solutionuser', to: 'test#solutionuser'
  get '/test/solution_user', to: 'test#solution_user'
  get '/test/casecomments', to: 'test#casecomments'
  get '/test/case_comments', to: 'test#case_comments'
  post '/test/addfilter', to: 'test#addfilter'
  get '/test/findapi', to: 'test#findapi'
  get '/test/ocm_find', to: 'test#ocm_find'
  get '/index', to: 'test#index'
  get '/test/colorchange', to: 'test#colorchange'
  get '/test/color_change', to: 'test#color_change'
  get '/cases/reverse', to: 'cases#reverse'
  get '/test/removefilter', to: 'test#removefilter'

  get "/solutions/", to: "solutions#index"
  get "/cases/", to: "cases#index"
  get 'engineer_bugs', to: 'engineers#bugs'
  get 'new_comment', to: 'solutions#new_comment'
  get '/tag_groups', to: 'tag_groups#new'
  get '/tag_groups/former', to: 'tag_groups#former'
  get '/tag_group/former', to: 'tag_groups#former'
  get '/tags/maketags', to: 'tags#new'
  post '/tags/new', to: 'tags#new'
  get '/tags', to: 'tags#new'
  post '/tags', to: 'tags#create'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "test#index"
  get "/stuff", to: "test#index"

  resources :articles do
    resources :comments
  end
  
  resources :tag_groups do
    resources :tag_items
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

  resources :bugs do
    resources :comments
  end

  resources :cases do
    resources :comments
  end

  resources :engineer_tags

  resources :commands do
    resources :comments
    resources :tags
  end

end
