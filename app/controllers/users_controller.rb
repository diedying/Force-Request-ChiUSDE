class UsersController < ApplicationController
  include SessionHelper
  
  def index
    @users = User.all
  end
  
  
  def signup
    session_update(:current_state, nil)
    
    # session_update(:name, params[:session][:name])
    # session_update(:email, params[:session][:email])
    
    
    @cur_user = User.where("name ='#{params[:session][:name]}' and email ='#{params[:session][:email]}'")
    if @cur_user[0].nil?
      @user = User.create!(:name => params[:session][:name], :email => params[:session][:email])
      flash[:notice] = "#{@user.name} #{@user.email} signed up successfully."
    else
      flash[:notice] = "Your record is already there"
    end
    
    
    @cur_user = User.where("name = 'Mo Li'")
    @cur_user.each do |record|
      session_update(:name, record.name)
    end
    
    
    # session_update(:name, @cur_user.name)
    # session_update(:email, "#{cur_user.email}")
    
    
    
    # @user = User.create!(:name => params[:session][:name], :email => params[:session][:email])
    # flash[:notice] = "#{@user.name} #{@user.email} signed up successfully."
    
    
    # session_update(:current_state, nil)
    # if params[:session][:uin] =~ /^\d+$/
    #   session_update(:uin, params[:session][:uin])
      
    #   session_update(:password, params[:session][:password])
      
    #   if Admin.exists?(:uin => session_get(:uin))
    #     session_update(:current_state, "admin")
    #     redirect_to student_requests_adminview_path
    #   else
    #     session_update(:current_state, "student")
    #     redirect_to student_requests_path
    #   end
    # else
    #   flash[:warning] = "Invalid UIN format"
    #   redirect_to root_path
    # end
    redirect_to users_path
  end
end
