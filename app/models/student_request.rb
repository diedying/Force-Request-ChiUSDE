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
    
    time = Time.new
    # List Year and Semester
    CURRENT_YEAR = time.strftime("%Y")
    current_year = CURRENT_YEAR.to_i
    
    LIST_YEAR = []
    for i in current_year..current_year+10
      LIST_YEAR << i.to_s
    end
    
    LIST_SEMESTER = ['Spring', 'Fall', 'Summer']
    
    YEAR_SEMESTER = []
    LIST_YEAR.each do |year|
      LIST_SEMESTER.each do |semester|
        YEAR_SEMESTER << year + " " + semester
      end
    end
    
    REQUEST_SEMESTER = []
    for i in current_year..current_year+1
      LIST_SEMESTER.each do |semester|
        REQUEST_SEMESTER << i.to_s + " " + semester
      end
    end
    
    self.primary_key = "request_id"
    validates :uin, presence: true
    validates :full_name, presence: true
    validates :major, presence: true
    validates :classification, presence: true
    validates :email, presence: true
    validates :request_semester, presence: true
    validates :course_id, presence: true
    validates :classification, inclusion: { in: CLASSIFICATION_LIST, 
      message: "%{value} is not a valid classification" }
    validates :request_semester, inclusion: { in: YEAR_SEMESTER, 
      message: "%{value} is not a valid request semester" }
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