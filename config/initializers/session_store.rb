# Be sure to restart your server when you modify this file.


#  require 'securerandom'

# def secure_token
#   token_file = Rails.root.join('.secret')
#   if File.exist?(token_file)
#     # Use the existing token.
#     File.read(token_file).chomp
#   else
#     # Generate a new token and store it in token_file.
#     token = SecureRandom.hex(64)
#     File.write(token_file, token)
#     token
#   end
# end

# Rails.application.config.session_store :cookie_store, key: 'secure_token'
# blog_test_project_brsoft::Application.config.secret_key_base = secure_token


	Rails.application.config.session_store :cookie_store, key: '_user_registration_session'
# Rails.application.config.session_store :cookie_store, key: 'secure_token'
