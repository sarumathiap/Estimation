

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '154401226893-fgghq1ice4gkt0ca67ooi0i51tqfaei7.apps.googleusercontent.com', '86VwGsagx1-4tXC8vzZfVX2G', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
