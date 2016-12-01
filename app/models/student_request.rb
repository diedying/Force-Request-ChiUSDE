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
    CURRENT_MONTH = time.strftime("%m")
    current_month = CURRENT_MONTH.to_i
    
    LIST_YEAR = []
    for i in current_year..current_year+10
      LIST_YEAR << i.to_s
    end
    
    LIST_SEMESTER = ['Spring', 'Fall', 'Summer']
    
    YEAR_SEMESTER = []
    LIST_YEAR.each do |year|
      LIST_SEMESTER.each do |semester|
        if year.to_i == current_year and current_month <= 4
          YEAR_SEMESTER << year + " " + semester
        elsif year.to_i == current_year and current_month <= 8 and semester != "Spring"
          YEAR_SEMESTER << year + " " + semester
        elsif semester == "Fall"
          YEAR_SEMESTER << year + " " + semester
        elsif year.to_i != current_year
          YEAR_SEMESTER << year + " " + semester
        end
      end
    end
    
    REQUEST_SEMESTER = []
    for i in current_year..current_year+1
      LIST_SEMESTER.each do |semester|
        if i == current_year and current_month <= 4
          REQUEST_SEMESTER << i.to_s + " " + semester
        elsif i == current_year and current_month <= 8 and semester != "Spring"
          REQUEST_SEMESTER << i.to_s + " " + semester
        elsif semester == "Fall"
          REQUEST_SEMESTER << i.to_s + " " + semester
        elsif i != current_year
          REQUEST_SEMESTER << i.to_s + " " + semester
        end
      end
    end
    
    self.primary_key = "request_id"
    validates :uin, presence: true
    validates :full_name, presence: true
    validates_format_of :full_name, :with => /^[^0-9`!@#\$%\^&*+_=]+$/, :multiline => true
    validates :major, presence: true
    validates :classification, presence: true
    validates :email, presence: true
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    validates :request_semester, presence: true
    validates :course_id, presence: true
    validates_format_of :course_id, :with => /^\d+$/, :multiline => true
    validates_format_of :section_id, :with => /^\d*$/, :multiline => true
    validates_format_of :phone, :with => /1?\s*\W?\s*([2-9][0-8][0-9])\s*\W?\s*([2-9][0-9]{2})\s*\W?\s*([0-9]{4})(\se?x?t?(\d*))?/
    validates_format_of :minor, :with => /^[a-zA-Z]{4}$/, :multiline => true
    validates :classification, inclusion: { in: CLASSIFICATION_LIST, 
      message: "%{value} is not a valid classification" }
    validates :request_semester, inclusion: { in: YEAR_SEMESTER, 
      message: "%{value} is not a valid request semester" }
    before_create :create_request_id
    before_save :update_time
    
    before_create :set_creation_date
  
    def set_creation_date
      self.creation_date = DateTime.now()
    end

    def update_time
      self.last_updated = DateTime.now()
    end
    
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