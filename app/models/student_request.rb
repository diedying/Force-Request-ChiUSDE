class StudentRequest < ActiveRecord::Base
  
  
  # States of the students 
    ACTIVE_STATE = "Active"
    WITHDRAWN_STATE = "Withdraw"
    REJECTED_STATE = "Rejected"
    HOLD_STATE = "Hold"
    APPROVED_STATE = "Approved"
    
    # Priority of the Students
    VERYHIGH_PRIORITY = "Very High"
    HIGH_PRIORITY = "High"
    NORMAL_PRIORITY = "Normal"
    LOW_PRIORITY = "Low"
    VERYLOW_PRIORITY = "Very Low"
    
    self.primary_key = "request_id"
    validates :uin, presence: true
    validates :full_name, presence: true
    validates :major, presence: true
    validates :classification, presence: true
    validates :email, presence: true
    validates :request_semester, presence: true
    validates :course_id, presence: true
    before_create :create_request_id

    def create_request_id
      begin
        self. request_id = "FRS" + SecureRandom.hex(10)
      end while self.class.exists?(:request_id => request_id)
    end
end