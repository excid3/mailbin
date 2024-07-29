Mailbin::Engine.routes.draw do
  resources :messages do
    collection do
      resource :clear
    end
  end

  root to: "messages#index"
end
