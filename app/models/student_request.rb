class StudentRequest < ActiveRecord::Base
    self.primary_key = "request_id"
    validates :uin, presence: true
    before_create :create_request_id

    def create_request_id
      begin
        self. request_id = SecureRandom.hex(5) # or whatever you chose like UUID tools
      end while self.class.exists?(:request_id => request_id)
    end
end