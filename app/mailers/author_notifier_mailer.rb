class AuthorNotifierMailer < ApplicationMailer
    default :from => 'maria@ifixmii.com'

    # send a signup email to the user, pass in the user object that   contains the user's email address
    def send_signup_email
      mail( :to => "mar.alvareg@gmail.com",
      :subject => 'Thanks for signing up for our amazing app' )
    end
end
