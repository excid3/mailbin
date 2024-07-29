MailDrop::Engine.routes.draw do
  resources :messages, id: /([^\/])+?/ do
    collection do
      resource :clear
    end
  end

  root to: "messages#index"
end
