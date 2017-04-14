class StudentMailer < ActionMailer::Base
    default :from => 'limo9373@gmail.com'

    def registration_confirmation(student)
        @student = student
        # mail(:to => "#{student.name} <#{student.email}>", :subject => "Registration Confirmation")
        mail(:to => @student.email, :subject => "Registration Confirmation")
    end
    
    def reset_password(student)
        @student = student
        mail(:to => @student.email, :subject => "Reset Your Password")
    end
end 