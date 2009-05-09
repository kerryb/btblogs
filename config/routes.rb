ActionController::Routing::Routes.draw do |map|
  map.confirm 'blogs/confirm/:confirmation_code', :controller => 'blogs', :action => 'confirm'
  map.resources :blogs, :only => [:create, :new]
  map.root :controller => 'pages', :action => 'home'
end
