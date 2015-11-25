ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 25, # 587
    :domain               => "voroninstudio.eu",
    :user_name            => "support@voroninstudio.eu",
    :password             => "NewPashaPassword12345",
    :authentication       => "plain",
    :enable_starttls_auto => true # default: true
}