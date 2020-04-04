Rails.application.routes.draw do
  devise_for :patients, path: 'patients', controllers: { sessions: 'patients/sessions' }
  devise_for :users, path: 'users'

  devise_scope :patient do
    root 'patients/sessions#new'
  end

  devise_scope :user do
    match 'ubs/active_hours', via: [:get, :post], as: :ubs_active_hour
    match 'ubs/slot_duration', via: [:get, :post], as: :ubs_slot_duration
  end
end
