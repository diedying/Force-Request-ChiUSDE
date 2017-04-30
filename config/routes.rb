Rails.application.routes.draw do

  root 'student_requests#login_page'
  
  get 'student_requests/adminview' => 'student_requests#adminview'
  put 'student_requests/updaterequestbyadmin' => 'student_requests#updaterequestbyadmin'
  put 'student_requests/multiupdate' => 'student_requests#multiupdate'

  post 'student_requests/login' => 'student_requests#login'
  get 'student_requests/getSpreadsheet' => 'student_requests#getSpreadsheet'
  get 'student_requests/getSpreadsheetAllCourses' => 'student_requests#getSpreadsheetAllCourses'
  get 'student_requests/uin/:uin' => 'student_requests#getStudentInformationByUin'
  get 'student_requests/id/:id' => 'student_requests#getStudentInformationById'
  
  get 'student_requests/adminprivileges' => 'student_requests#adminprivileges'
  post 'student_requests/addadmin' => 'student_requests#addadmin'
  post 'student_requests/add_student' => 'student_requests#add_student'
  get 'student_requests/add_new_force_request' => 'student_requests#add_new_force_request'
  post 'student_requests/add_new_force_request' => 'student_requests#add_force_request' 
  
  
  delete 'student_requests/deleteall' => 'student_requests#deleteall'
  get 'student_requests/homeRedirect' => 'student_requests#homeRedirect'
  
  post 'student_requests/logout' => 'student_requests#logout'

  resources :student_requests
  
  
  # resources :students do
  #   member do
  #     get :confirm_email
  #   end
  # end
  get 'students/confirm_email/:id' => 'students#confirm_email', as: 'confirm_email'
  get 'students/signup' => 'students#signup'
  post 'students/create' => 'students#create'
  #show the student dashboard
  get 'students/show' => 'students#show'
  #show the student profile
  get 'students/profile' => 'students#profile'
  #after login then change password
  get 'students/edit_password' => 'students#edit_password'
  post 'students/update_password' => 'students#update_password'
  #before login forget password, then change password
  get 'students/forget_password' => 'students#forget_password'
  post 'students/sent_reset_password_mail' => 'students#sent_reset_password_mail'
  get 'students/reset_password/:id' => 'students#reset_password', as: 'reset_password'
  post 'students/update_reset_password' => 'students#update_reset_password'
  get 'students/add_new_student' => 'students#add_new_student'
  post 'students/add_new_student' => 'students#add_student'
  
  
  # Admin
  get 'admins/add_new_admin' => 'admins#add_new_admin'
  post 'admins/add_new_admin' => 'admins#addAdmin'
  
end
