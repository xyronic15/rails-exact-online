# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  def exact_online
    # puts "Session State: #{session['omniauth.state']}"
    # puts "Params State: #{params[:state]}"

    # if session['omniauth.state'] != params[:state]
    #   return redirect_to root_path, alert: 'State parameter mismatch'
    # end

    auth = request.env['omniauth.auth']
    puts "Auth data: #{auth.to_yaml}"
    redirect_to root_path, notice: "Callback successful"
  end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  def failure
    # puts "Session State: #{session['omniauth.state']}"
    redirect_to root_path, alert: 'Authentication failed'
  end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
