class UsersController < ApplicationController
  include SessionHelper

  def index
    @users = User.all
  end
  
  def signup
    @cur_user = User.where("name ='#{params[:session][:name]}' and email ='#{params[:session][:email]}' and password ='#{params[:session][:password]}'")
    if @cur_user[0].nil?
      @user = User.create!(:name => params[:session][:name], :email => params[:session][:email], :password => params[:session][:password] )
      flash[:notice] = "#{@user.name} #{@user.email} #{@user.password} signed up successfully."
    else
      flash[:notice] = "Your record is already there"
    end
    redirect_to users_path
  end
  
  def signupPage
    redirect_to new_user_path
  end
  
  def login
    
    session_update(:current_state, nil)
    #first, check if the input uin is valid
    if params[:session][:uin] =~ /^\d+$/
      @cur_user = User.where("uin ='#{params[:session][:uin]}' and password ='#{params[:session][:password]}'")
      @cur_admin = Admin.where("uin ='#{params[:session][:uin]}' and password ='#{params[:session][:password]}'")
      
      session_update(:password, params[:session][:password])
      session_update(:uin, params[:session][:uin])
      #check if this uin is admin or student
      # if Admin.exists?(:uin => session_get(:uin))
      if @cur_admin[0].nil? and @cur_user[0].nil?
        flash[:notice] = "Your UIN or Password is WRONG!"
        redirect_to root_path
      #then, check if it is admin
      elsif @cur_user[0].nil?
        session_update(:name, @cur_admin[0][:name])
        session_update(:current_state, "admin")
        redirect_to student_requests_adminview_path
      #if not, it must be a student
      else
        session_update(:name, @cur_user[0][:name])
        session_update(:current_state, "student")
        redirect_to student_requests_path
      end
    else
      flash[:warning] = "Invalid UIN format"
      redirect_to root_path
    end
  end
end
