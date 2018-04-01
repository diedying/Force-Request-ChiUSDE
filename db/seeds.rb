# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


student_requests = []

majors = [                 
            {:major_id => 'Computer Science'},         
            {:major_id => 'Computer Engineering'},
            {:major_id => 'Electrical Engineering'},
            {:major_id => 'Applied Mathematical Sciences'},            
            
            {:major_id => 'Accounting'}, 
            {:major_id => 'Aerospace Engineering'},
            {:major_id => 'Agribusiness'}, 
            {:major_id => 'Agricultural Communications & Journalism'}, 
            {:major_id => 'Agricultural Economics'}, 
            {:major_id => 'Agricultural Leadership & Development'}, 
            {:major_id => 'Agricultural Economics'}, 
            {:major_id => 'Agricultural Science'}, 
            {:major_id => 'Allied Health'},
            {:major_id => 'Animal Science'},
            {:major_id => 'Anthropology'},

            {:major_id => 'Biochemistry'},
            {:major_id => 'Bioenvironmental Sciences'},
            {:major_id => 'Biological & Agricultural Engineering'},
            {:major_id => 'Biology'},
            {:major_id => 'Biomedical Engineering'},
            {:major_id => 'Biomedical Sciences'},
            {:major_id => 'Chemical Engineering'},
            {:major_id => 'Chemistry'},
            {:major_id => 'Civil Engineering'},
            {:major_id => 'Classics'},
            {:major_id => 'Communication'},
            {:major_id => 'Community Health'},
            {:major_id => 'Construction Science'},
            {:major_id => 'Dance Science'},
            {:major_id => 'Ecological Restoration'},
            {:major_id => 'Economics'},

            {:major_id => 'Electronic Systems Engineering Technology'},
            {:major_id => 'English'},
            {:major_id => 'Entomology'},
            {:major_id => 'Environmental Design'},
            {:major_id => 'Environmental Geosciences'},
            {:major_id => 'Environmental Studies (Geosciences)'},
            {:major_id => 'Environmental Studies (Plant Pathology & Microbiology)'},
            {:major_id => 'Finance'},
            {:major_id => 'Food Science & Technology'},
            {:major_id => 'Forensic & Investigative Sciences'},            
            {:major_id => 'Forestry'},
            {:major_id => 'Finance'},
            {:major_id => 'Genetics'},
            {:major_id => 'Geographic Information Science & Technology'},
            {:major_id => 'Geography'},
            {:major_id => 'Geology'},
            {:major_id => 'Geophysics'},
            {:major_id => 'History'},
            {:major_id => 'Horticulture'},
            {:major_id => 'Human Resource Development'},
            {:major_id => 'Industrial Distribution'},
            {:major_id => 'Industrial Engineering'},
            {:major_id => 'Interdisciplinary Studies-Bilingual Education'},
            {:major_id => 'Interdisciplinary Studies-Early Childhood'},
            {:major_id => 'Interdisciplinary Studies-Middle Grades English/Language Arts/Social Studies'},
            {:major_id => 'Interdisciplinary Studies-Middle Grades Math/Science'},
            {:major_id => 'Interdisciplinary Studies-Special Education'},
            {:major_id => 'International Studies'},
            {:major_id => 'Kinesiology-Applied Exercise Physiology'},
            {:major_id => 'Kinesiology-Basic Exercise Physiology'},
            {:major_id => 'Kinesiology-Motor Behavior'},
            {:major_id => 'Kinesiology-Physical Education Certification'},
            {:major_id => 'Landscape Architecture'},
            {:major_id => 'Management'},
            {:major_id => 'Management Information Systems'},
            {:major_id => 'Manufacturing & Mechanical Engineering Technology'},
            {:major_id => 'Marine Biology'},
            {:major_id => 'Marine Engineering Technology'},
            {:major_id => 'Marine Fisheries'},
            {:major_id => 'Marine Sciences'},
            {:major_id => 'Marine Transportation'},
            {:major_id => 'Maritime Administration'},
            {:major_id => 'Maritime Studies'},
            {:major_id => 'Marketing'},
            {:major_id => 'Materials Science & Engineering'},
            {:major_id => 'Mathematics'},
            {:major_id => 'Mechanical Engineering'},
            {:major_id => 'Meteorology'},
            {:major_id => 'Microbiology'},
            {:major_id => 'Modern Languages'},
            {:major_id => 'Molecular & Cell Biology'},
            {:major_id => 'Multidisciplinary Engineering Technology'},
            {:major_id => 'Nuclear Engineering'},
            {:major_id => 'Nutritional Sciences'},
            {:major_id => 'Ocean and Coastal Resources'},
            {:major_id => 'Ocean Engineering'},
            {:major_id => 'Oceanography'},
            {:major_id => 'Offshore and Coastal Systems Engineering'},
            {:major_id => 'Performance Studies'},
            {:major_id => 'Petroleum Engineering'},
            {:major_id => 'Philosophy'},
            {:major_id => 'Plant & Environmental Soil Science'},
            {:major_id => 'Political Science'},
            {:major_id => 'Poultry Science'},
            {:major_id => 'Psychology'},
            {:major_id => 'Public Health'},            
            {:major_id => 'Rangeland Ecology & Management'},            
            {:major_id => 'Recreation, Park & Tourism Sciences'},            
            {:major_id => 'Renewable Natural Resources'},
            {:major_id => 'School Health'},
            {:major_id => 'Sociology'},
            {:major_id => 'Spanish'},
            {:major_id => 'Spatial Sciences'},
            {:major_id => 'Sport Management'},
            {:major_id => 'Statistics'},
            {:major_id => 'Supply Chain Management'},
            {:major_id => 'Technology Management'},
            {:major_id => 'Telecommunication Media Studies'},
            {:major_id => 'Turfgrass Science'},
            {:major_id => 'University Studies - Architecture'},
            {:major_id => 'University Studies - Child Professional Services'},
            {:major_id => 'University Studies - Dance'},
            {:major_id => 'University Studies - Environmental Business'},
            {:major_id => 'University Studies - Geography'},
            {:major_id => 'University Studies - GIS & Technology'},
            {:major_id => 'University Studies - Journalism'},
            {:major_id => 'University Studies - Leadership'},
            {:major_id => 'University Studies - Marine Environmental Law & Policy'},
            {:major_id => 'University Studies - Oceans and One Health'},
            {:major_id => 'University Studies - Race, Gender & Ethnicity'},
            {:major_id => 'University Studies - Religious Thought, Practices & Cultures'},
            {:major_id => 'University Studies - Society, Ethics & Law'},
            {:major_id => 'Urban & Regional Planning'},
            {:major_id => 'Visualization'},
            {:major_id => 'Wildlife & Fisheries Sciences'},
            {:major_id => 'Women\'s and Gender Studies'},
            {:major_id => 'Zoology'},           
            {:major_id => 'Others'}]
            
admins = [{:uin => '123456789', :name => 'admin', :password => 'tamu2017', :email => '123456789@tamu.edu'}]

students = []

students.each do |student|
   Student.create!(student) 
end

student_requests.each do |record|
  StudentRequest.create!(record)
end

majors.each do |record|
  Major.create!(record)
end

admins.each do |record|
  Admin.create!(record)
end
