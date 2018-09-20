

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '826042184542-r39n4hh3r6ke33b0mh22p259odp15kq8.apps.googleusercontent.com', 'YDlZ-UarGnKyp74GuyOsZgtm', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
