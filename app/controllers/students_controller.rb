class StudentsController < ApplicationController
    def signup
    end
    #create a new student record
    def create
        @student = Student.where("name ='#{params[:session][:name]}' and email ='#{params[:session][:email]}' and password ='#{params[:session][:password]}'")
        if @student[0].nil?
            @newStudent = Student.create!(:name => params[:session][:name], :uin => params[:session][:uin], :email => params[:session][:email], :password => params[:session][:password] )
            flash[:notice] = "#{@newStudent.name} #{@newStudent.email} #{@newStudent.uin} signed up successfully."
        else
            flash[:notice] = "Your record is already there"
        end
        redirect_to root_path
    end
    
end