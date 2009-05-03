ActionController::Routing::Routes.draw do |map|
  map.resources :blogs, :only => [:new]
  map.root :controller => 'pages', :action => 'home'
end
