class StudentsController < ApplicationController
    include SessionHelper
    include ScrapeHelper
    
    #show the student dashboard page
    def show
        if session_get(:uin) == nil
            redirect_to root_path
        else
            @student_requests = StudentRequest.where(:uin => session_get(:uin))
        end 
    end
    
    def signup
    end
    #create a new student record
    def create
        #check the reenter uin and email is same
        if params[:session][:uin2] == params[:session][:uin] and params[:session][:password2] == params[:session][:password]
            #use the uin and email to check if the student has signed up
            @student = Student.where("uin = '#{params[:session][:uin]}'")
            #check if the student has signed up before
            if @student[0].nil?
                #check if the input information matched to the information scraped
                if scrape_info(params[:session][:name], params[:session][:email]) != {}
                    record = scrape_info(params[:session][:name], params[:session][:email])
                    
                    #update records to standard format
                    @newStudent = Student.create!(:name => record['First Name']+' '+record['Last Name'], :uin => params[:session][:uin], :email => record['Email Address'], :password => params[:session][:password],
                                              :major => record['Major'], :classification => record['Classification'])
                    flash[:notice] = "Name:#{@newStudent.name}, UIN: #{@newStudent.uin}, Email: #{@newStudent.name} signed up successfully."
                    redirect_to root_path
                else
                    flash[:notice] = "Your information is incorrect!\nPlease use your TAMU email to register!\nUse your name as which is on your Student ID!"
                    redirect_to students_signup_path
                end
            else
                flash[:notice] = "Your record is already there"
                redirect_to root_path
            end
             
        else
            flash[:notice] = "The twice entered UIN and password must be same!"
            redirect_to students_signup_path
        end
    end
    #after login to update the password(create new password)
    def update_password
        @student = Student.where(:uin => session_get(:uin))
        if @student[0].password == params[:session][:oldPassword]
            if params[:session][:password] == params[:session][:password2]
                @student[0].update_attribute(:password, params[:session][:password])
                flash[:notice] = "Your password has been changed!"
                redirect_to students_show_path
            else
                flash[:warning] = "The twice entered new password must be same!"
                redirect_to students_edit_password_path 
            end
        else
            flash[:warning] = "The old password you enter is wrong!"
            redirect_to students_edit_password_path 
        end
    end
    #before login(forget the password) to update the password(create password)
    def update_forgotten_password
        if params[:session][:uin] == params[:session][:uin2]
            @student = Student.where("uin ='#{params[:session][:uin]}'")
            if @student[0].nil?
                flash[:warning] = "The student of UIN doesn't sign up"
                redirect_to '/students/forget_password'  
            else
                   if params[:session][:password] == params[:session][:password2]
                       @student[0].update_attribute(:password, params[:session][:password])
                       flash[:notice] = "Your password has been changed!"
                       redirect_to root_path 
                   else
                       flash[:warning] = "The twice entered new password must be same!"
                       redirect_to '/students/forget_password' 
                   end
            end
        elsif 
            flash[:warning] = "The twice entered UIN must be same!"
            redirect_to '/students/forget_password'
        end
    end
    
    def profile
        @students = Student.where(:uin => session_get(:uin))
    end
end