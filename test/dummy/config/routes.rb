Rails.application.routes.draw do
  mount Paymob::Engine::Engine => "/paymob-engine"
end
