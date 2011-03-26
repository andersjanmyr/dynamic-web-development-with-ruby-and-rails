!SLIDE center
# Integration


!SLIDE small
# devise (authentication)

    @@@ruby
    # routes.rb
    devise_for :users

    # new_user_session GET    /users/sign_in(.:format)    {:action=>"new", :controller=>"devise/sessions"}
    # user_session POST   /users/sign_in(.:format)        {:action=>"create", :controller=>"devise/sessions"}
    # destroy_user_session GET   /uses/sign_out(.:format) {:action=>"destroy", :controller=>"devise/sessions"}

    class User < ActiveRecord::Base
      devise :database_authenticatable, :recoverable,
        :rememberable, :trackable, :validatable



!SLIDE small
# omniauth (authentication)

    @@@ruby
    require 'omniauth'
    use Rack::Session::Cookie # OmniAuth requires sessions.
    use OmniAuth::Builder do
      provider :twitter, "CONSUMER_KEY", "CONSUMER_SECRET"
      provider :facebook, "APP_ID", "APP_SECRET"
    end

    # routes.rb
    match '/auth/:provider/callback', :to => 'sessions#create'

!SLIDE small
# S3 via Paperclip

    @@@ruby
    class Item < ActiveRecord::Base
      has_attached_file :attachment, :storage => :s3, 
        :s3_credentials => "#{Rails.root}/config/s3.yml"
    

    # s3.yml
    development:
      bucket: helios-development
      access_key_id: AKIAIBRXXXXXXFWH3VZA
      secret_access_key: lQRzdUr/9MXXXXXXXXXrMNyV7R6
        
