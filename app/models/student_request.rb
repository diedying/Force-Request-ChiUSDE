class StudentRequest < ActiveRecord::Base
    self.primary_key = "request_id"
    validates :uin, presence: true
    before_create :create_request_id

    def create_request_id
      begin
        self. request_id = "FRS" + SecureRandom.hex(10)
      end while self.class.exists?(:request_id => request_id)
    end
end