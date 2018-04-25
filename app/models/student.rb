class Student < ActiveRecord::Base
    validates :name, presence: true
    validates :email, presence: true
    validates :password, presence: true
    validates :uin, presence: true
    # validates_format_of :email, :with => /\A(\w+)@(tamu.edu)\z/i
    validates_format_of :name, :with => /\w+/, :multiline => true
    # # attr_accessor :name, :email
    
    attr_encrypted :email, key: ENV['EMAIL_KEY'].truncate(32), iv: ENV['EMAIL_IV'].truncate(12), mode: :single_iv_and_salt, insecure_mode: true
    attr_encrypted :password, key: ENV['PASSWORD_KEY'].truncate(32), iv: ENV['PASSWORD_IV'].truncate(12), mode: :single_iv_and_salt, insecure_mode: true
    
    before_create :confirmation_token
    
    def email_activate
        self.email_confirmed = true
        self.confirm_token = nil
        # save!(:validate => false)
        save!()
    end
    
    def password_reset_done
        self.reset_password_confirm_token = nil
        save!()
    end
    
    def reset_password_confirmation_token
        update_attribute(:reset_sent_at, Time.zone.now)#the time of the reset email sent
        if self.reset_password_confirm_token.blank?
            self.reset_password_confirm_token = SecureRandom.urlsafe_base64.to_s
            save!()
        end
    end
    
    def password_reset_expired?
        self.reset_sent_at < 1.hour.ago
    end

    private
    def confirmation_token
      if self.confirm_token.blank?
          self.confirm_token = SecureRandom.urlsafe_base64.to_s
      end
    end
end