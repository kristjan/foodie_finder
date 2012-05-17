FoodieFinder::Application.routes.draw do
  match "auth/:service"          => "auth#service"
  match "auth/:service/callback" => "auth#callback"
  match "logout"                 => "auth#logout"
  match "friends"                => "default#friends"
  root :to                       => "default#home"
  match ":controller/:action"
end
