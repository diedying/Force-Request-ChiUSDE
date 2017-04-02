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
  delete 'student_requests/deleteall' => 'student_requests#deleteall'
  get 'student_requests/homeRedirect' => 'student_requests#homeRedirect'
  
  post 'student_requests/logout' => 'student_requests#logout'

  resources :student_requests
  
  get 'students/signup' => 'students#signup'
  post 'students/create' => 'students#create'
  post 'student_requests/index' => 'student_requests#cancel'
  get 'students/forgetPW' => 'students#forgetPW'
  post 'students/updatePW' => 'students#updatePW'
  
end
