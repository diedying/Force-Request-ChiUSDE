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
    
    STATES_AVAILABLE_TO_ADMIN = [StudentRequest::APPROVED_STATE, StudentRequest::REJECTED_STATE, StudentRequest::HOLD_STATE]
    PRIORITY_LIST = [StudentRequest::VERYHIGH_PRIORITY, StudentRequest::HIGH_PRIORITY, StudentRequest::NORMAL_PRIORITY, StudentRequest::LOW_PRIORITY, StudentRequest::VERYLOW_PRIORITY]
    
    #Classification
    CLASSIFICATION_LIST = ['U1', 'U2', 'U3', 'U4', 'G']
    MAJOR_LIST = [      
             'None',    
             'Computer Science', 

             'Computer Engineering',
             'Electrical Engineering',
             'Applied Mathematical Sciences',            
            
             'Accounting', 
             'Aerospace Engineering',
             'Agribusiness', 
             'Agricultural Communications & Journalism', 
             'Agricultural Economics', 
             'Agricultural Leadership & Development', 
             'Agricultural Economics', 
             'Agricultural Science', 
             'Allied Health',
             'Animal Science',
             'Anthropology',

             'Biochemistry',
             'Bioenvironmental Sciences',
             'Biological & Agricultural Engineering',
             'Biology',
             'Biomedical Engineering',
             'Biomedical Sciences',
             'Chemical Engineering',
             'Chemistry',
             'Civil Engineering',
             'Classics',
             'Communication',
             'Community Health',
             'Construction Science',
             'Dance Science',
             'Ecological Restoration',
             'Economics',

             'Electronic Systems Engineering Technology',
             'English',
             'Entomology',
             'Environmental Design',
             'Environmental Geosciences',
             'Environmental Studies (Geosciences)',
             'Environmental Studies (Plant Pathology & Microbiology)',
             'Finance',
             'Food Science & Technology',
             'Forensic & Investigative Sciences',            
             'Forestry',
             'Finance',
             'Genetics',
             'Geographic Information Science & Technology',
             'Geography',
             'Geology',
             'Geophysics',
             'History',
             'Horticulture',
             'Human Resource Development',
             'Industrial Distribution',
             'Industrial Engineering',
             'Interdisciplinary Studies-Bilingual Education',
             'Interdisciplinary Studies-Early Childhood',
             'Interdisciplinary Studies-Middle Grades English/Language Arts/Social Studies',
             'Interdisciplinary Studies-Middle Grades Math/Science',
             'Interdisciplinary Studies-Special Education',
             'International Studies',
             'Kinesiology-Applied Exercise Physiology',
             'Kinesiology-Basic Exercise Physiology',
             'Kinesiology-Motor Behavior',
             'Kinesiology-Physical Education Certification',
             'Landscape Architecture',
             'Management',
             'Management Information Systems',
             'Manufacturing & Mechanical Engineering Technology',
             'Marine Biology',
             'Marine Engineering Technology',
             'Marine Fisheries',
             'Marine Sciences',
             'Marine Transportation',
             'Maritime Administration',
             'Maritime Studies',
             'Marketing',
             'Materials Science & Engineering',
             'Mathematics',
             'Mechanical Engineering',
             'Meteorology',
             'Microbiology',
             'Modern Languages',
             'Molecular & Cell Biology',
             'Multidisciplinary Engineering Technology',
             'Nuclear Engineering',
             'Nutritional Sciences',
             'Ocean and Coastal Resources',
             'Ocean Engineering',
             'Oceanography',
             'Offshore and Coastal Systems Engineering',
             'Performance Studies',
             'Petroleum Engineering',
             'Philosophy',
             'Plant & Environmental Soil Science',
             'Political Science',
             'Poultry Science',
             'Psychology',
             'Public Health',            
             'Rangeland Ecology & Management',            
             'Recreation, Park & Tourism Sciences',            
             'Renewable Natural Resources',
             'School Health',
             'Sociology',
             'Spanish',
             'Spatial Sciences',
             'Sport Management',
             'Statistics',
             'Supply Chain Management',
             'Technology Management',
             'Telecommunication Media Studies',
             'Turfgrass Science',
             'University Studies - Architecture',
             'University Studies - Child Professional Services',
             'University Studies - Dance',
             'University Studies - Environmental Business',
             'University Studies - Geography',
             'University Studies - GIS & Technology',
             'University Studies - Journalism',
             'University Studies - Leadership',
             'University Studies - Marine Environmental Law & Policy',
             'University Studies - Oceans and One Health',
             'University Studies - Race, Gender & Ethnicity',
             'University Studies - Religious Thought, Practices & Cultures',
             'University Studies - Society, Ethics & Law',
             'Urban & Regional Planning',
             'Visualization',
             'Wildlife & Fisheries Sciences',
             'Women\'s and Gender Studies',
             'Zoology',           
             'Others']
    # time = Time.new
    Time.zone = 'Central Time (US & Canada)'
    time = Time.zone.now()
    
    # List Year and Semester
    CURRENT_YEAR = time.strftime("%Y")
    current_year = CURRENT_YEAR.to_i
    CURRENT_MONTH = time.strftime("%m")
    current_month = CURRENT_MONTH.to_i
    
    LIST_YEAR = []
    for i in current_year..current_year+100
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
    validates :name, presence: true
    validates_format_of :name, :with => /^[^0-9`!@#\$%\^&*+_=]+$/, :multiline => true
    validates :major, presence: true
    validates :classification, presence: true
    validates :email, presence: true
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    validates :request_semester, presence: true
    validates :course_id, presence: true
    validates_format_of :course_id, :with => /^\d+$/, :multiline => true
    validates_format_of :section_id, :with => /^\d*$/, :multiline => true
    # validates_format_of :phone, :with => /1?\s*\W?\s*([2-9][0-8][0-9])\s*\W?\s*([2-9][0-9]{2})\s*\W?\s*([0-9]{4})(\se?x?t?(\d*))?/
    #validates :classification, inclusion: { in: CLASSIFICATION_LIST, 
    #  message: "%{value} is not a valid classification" }
    validates :request_semester, inclusion: { in: YEAR_SEMESTER, 
      message: "%{value} is not a valid request semester" }
    before_create :create_request_id
    before_save :update_time
    
    before_create :set_creation_date
  
    def set_creation_date
      # self.creation_date = DateTime.now()
      Time.zone = 'Central Time (US & Canada)'
      self.creation_date = Time.zone.now()
    end

    def update_time
      # self.last_updated = DateTime.now()
      Time.zone = 'Central Time (US & Canada)'
      self.last_updated = Time.zone.now()
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