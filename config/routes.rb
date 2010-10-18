ActionController::Routing::Routes.draw do |map|
  map.resources :tweets

  map.connect 'posts/tag/:tag', :controller => 'posts', :action => 'index'

  map.connect 'posts/:year/:month', :controller => 'posts',
              :year => nil, :month => nil, :requirements => {:year => /\d{4}/, :month => /\d{1,2}/}

  map.resources :posts do |entry|
    entry.resources  :comments
    entry.resources  :post_attachments
  end

  map.resources :sessions

  map.resources :users

  map.signup 'signup', :controller => 'users', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
  map.login 'login', :controller => 'sessions', :action => 'new'
  map.root :controller => "welcome"
  map.the_day 'the_day', :controller => 'the_day', :action => 'index'
  map.wedding_party 'wedding_party', :controller => 'wedding_party', :action => 'index'
  map.visualize 'visualize', :controller => 'visualize', :action => 'index'

  map.open_id_complete 'session', :controller => "session", :action => "create", :requirements => { :method => :get }
  

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
