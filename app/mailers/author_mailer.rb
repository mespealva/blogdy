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
    def send_simple_message
        RestClient.post "https://api.mailgun.net/v3/mg.ifixmii.com/messages",
        :from => "Excited User <mailgun@YOUR_DOMAIN_NAME>",
        :to => "bar@example.com, YOU@YOUR_DOMAIN_NAME",
        :subject => "Hello",
        :text => "Testing some Mailgun awesomness!"
    end
end