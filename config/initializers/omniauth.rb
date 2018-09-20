

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '839690650442-4q65r2e5258skbpcrehhcb5fb99aer2h.apps.googleusercontent.com', 'jCDw9ZWwly0oHD-bTessKbFQ', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end