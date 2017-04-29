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
        @student = Student.new
    end
    
    # create a new student
    def create
        @classificationList = StudentRequest::CLASSIFICATION_LIST
        @majorList = Major.pluck(:major_id)
        #check the reenter uin and email is same
        if params[:session][:uin2] == params[:session][:uin] and params[:session][:password2] == params[:session][:password]
            #use the uin and email to check if the student has signed up
            @student = Student.where("uin = '#{params[:session][:uin]}'")
            #check if the student has signed up before
            if @student[0].nil?
                #check if the input information matched to the information scraped
                if scrape_info(params[:session][:name], params[:session][:email]) != {}
                    record = scrape_info(params[:session][:name], params[:session][:email])
                    # sign up email confirm feature
                    # @newStudent = Student.new(:name => record['First Name']+' '+record['Last Name'], :uin => params[:session][:uin], :email => record['Email Address'], :password => params[:session][:password],
                    #                           :major => record['Major'], :classification => record['Classification'])
                    # if @newStudent.save
                    #     StudentMailer.registration_confirmation(@newStudent).deliver
                    #     flash[:notice] = "Please confirm your email address to continue"
                    #     redirect_to root_path
                    # else
                    #     flash[:error] = "Ooooppss, something went wrong!"
                    #     # render 'new'
                    #     redirect_to root_path
                    # end
                    #update records to standard format
                    @newStudent = Student.create!(:name => record['First Name']+' '+record['Last Name'], :uin => params[:session][:uin], :email => record['Email Address'], :password => params[:session][:password],
                                              :major => record['Major'], :classification => record['Classification'])
                    flash[:notice] = "Name:#{@newStudent.name}, UIN: #{@newStudent.uin}, Email: #{@newStudent.email} signed up successfully."
                    redirect_to root_path
                else
                    flash[:warning] = "Warning: Your information is incorrect!\nPlease use your TAMU email to register!\nUse your name as which is on your Student ID!"
                    redirect_to students_signup_path
                end
            else
                flash[:warning] = "Warning: Your record is already there"
                redirect_to root_path
            end
        else
            flash[:warning] = "Warning: The twice entered UIN and password must be same!"
            redirect_to students_signup_path
        end
    end
    
    def confirm_email
        student = Student.where("confirm_token = '#{params[:id]}'")
        if student[0]
            student[0].email_activate
            flash[:notice] = "Welcome to the Sample App! Your email has been confirmed. Please sign in to continue."
            redirect_to root_path
        else
            flash[:warning] = "Sorry. The link is expired!"
            redirect_to root_path
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
    #sent the reset forgotten password mail to student email
    def sent_reset_password_mail
        @student = Student.where("uin ='#{params[:session][:uin]}'")
        if @student[0].nil?#case : the UIN is not signed up
            flash[:warning] = "The student of UIN doesn't sign up"
            redirect_to '/students/forget_password'  
        else
            @student[0].reset_password_confirmation_token#create the reset password confirmation token and the reset email sent time
            StudentMailer.reset_password(@student[0]).deliver
            flash[:notice] = "Please check your tamu email to reset your password!"
            redirect_to root_path
        end
    end
    #before login(forget the password) to update the password(create password)
    def reset_password 
        @student = Student.where("reset_password_confirm_token = '#{params[:id]}'")
        if @student[0] and !(@student[0].password_reset_expired?)
            session_update(:name, @student[0][:name])
            session_update(:current_state, "student")
            session_update(:uin, @student[0][:uin])
        else#case 1. the link expire; case 2. the link has been used
            flash[:warning] = "Sorry. The link is expired!"
            redirect_to root_path
        end
    end
    
    def update_reset_password
        @student = Student.where(:uin => session_get(:uin))
        if params[:session][:password] == params[:session][:password2]
            @student[0].update_attribute(:password, params[:session][:password])
            @student[0].password_reset_done#finish the reset password
            session_update(:name, @student[0][:name])
            session_update(:current_state, "student")
            session_update(:uin, @student[0][:uin])
            flash[:notice] = "Your password has been changed!"
            redirect_to students_show_path
        else
            flash[:warning] = "The twice entered new password must be same!"
            redirect_to reset_password_url(@student[0].reset_password_confirm_token)
        end
    end
    
    def profile
        @students = Student.where(:uin => session_get(:uin))
    end
end