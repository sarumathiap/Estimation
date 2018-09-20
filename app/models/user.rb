class User < ActiveRecord::Base
  before_create :add_authorization
	validates :email, uniqueness: true, format: { with: /\b[A-Z0-9._%a-z\-]+@coupa\.com\z/,
                  message: "must be a coupa.com account" }
  

  puts ENV['current_controller']
  def self.from_omniauth(auth)

    data =where(provider: auth.provider, uid: auth.uid)
    

    
    auth.info.email = "demo1@coupa.com"
    if User.email_validation(auth.info.email) == true 
    	u=User.find_by(email: auth.info.email)
    	u.update(name:auth.info.name,  uid: auth.uid, provider: auth.provider,oauth_token: auth.credentials.token, oauth_expires_at: Time.at(auth.credentials.expires_at))
    	u
   else

    end

    
  end

  private
    def add_authorization
      if ENV['current_controller'] == "users"
        self.status = "0"
        self.role = "user"
      elsif ENV['current_controller'] == "infos"
        self.status = "1"  
      else
      end
    end

      def self.valid(email)

            if User.exists?(email: email)  
            	true
            elsif !User.exists?(email: email)
            	false
            else
            	nil
            end
      end  

   




   
    


    def self.email_validation(email)

      domain = email.split("@").last
      return true if domain == "coupa.com"
    end 


end
