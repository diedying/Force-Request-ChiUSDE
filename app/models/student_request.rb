class StudentRequest < ActiveRecord::Base
  
  audited
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
    
    #Classification
    CLASSIFICATION_LIST = ['U0', 'U1', 'U2', 'U3', 'U4', 'U5', 'G6', 'G7', 'G8', 'G9']
    
    # Expected Graduation List
    EXPECTED_GRADUATION_LIST = ['2017 Spring', '2017 Summer', '2017 Fall', '2018 Spring', '2018 Summer', '2018 Fall']
    
    # Expected Graduation List
    REQUEST_SEMESTER_LIST = ['2017 Spring', '2017 Summer', '2017 Fall']
    
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
    
    def self.to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |student_request|
          csv << student_request.attributes.values_at(*column_names)
        end
      end
    end
end