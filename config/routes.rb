SunraRestApi::Application.routes.draw do

  devise_for :admins, :skip => [:registrations, :passwords],
    :token_authentication_key => 'authentication_key'

  root :to => 'projects#index'
 
  match "/404" => "errors#not_found"
  match "/500" => "errors#exception"

  # Full nested heirarchy 
  resources :projects do
    resources :client_login
    resources :bookings do
      resources :recordings do
        resources :recording_formats
      end
    end
  end

  # routes to provide top level "all" views of each table
  resources :bookings do
    resources :recordings
  end

  resources :recordings do
    resources :recording_formats
  end

  resources :recording_formats
  resources :studio_lookups
  resources :client_login

  resources :quickproject, controller: 'projects', path_names: { new: 'quick'  }

  # currently unused
  resources :booking_contact_details
  resources :booking_contacts
  resources :booking_companies
  resources :format_lookups
  resources :distribution_audits
  resources :file_ops_audits

end
