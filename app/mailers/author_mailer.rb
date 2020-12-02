class AuthorMailer < ApplicationMailer
    def sample_email(user)
        @user = user
        admin = Author.first
        mg_client = Mailgun::Client.new ENV['APIMAIL']
        message_params = {:from    => @user.email,
                          :to      => admin.email,
                          :subject => 'Sample Mail using Mailgun API',
                          :text    => 'This mail is sent using Mailgun API via mailgun-ruby'}
        mg_client.send_message ENV['APIENV'], message_params
    end
end