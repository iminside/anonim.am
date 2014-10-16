Mail.defaults do
  
  delivery_method :smtp, {
    address:             'smtp.sendgrid.net',
    port:                '587',
    domain:              'heroku.com',
    user_name:           ENV['SENDGRID_USERNAME'],
    password:            ENV['SENDGRID_PASSWORD'],
    authentication:      :plain,
    enable_starttls_auto: true
  }
  
end