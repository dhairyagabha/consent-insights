# Below are the routes for madmin
namespace :madmin do
  resources :announcements
  resources :notifications
  namespace :active_storage do
    resources :blobs
  end
  resources :users
  namespace :active_storage do
    resources :attachments
  end
  resources :services
  namespace :active_storage do
    resources :variant_records
  end
  root to: "dashboard#show"
end
