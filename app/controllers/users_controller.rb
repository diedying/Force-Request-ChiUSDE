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
    @cur_user = User.where("name ='#{params[:session][:name]}' and password ='#{params[:session][:password]}'")
    if @cur_user[0].nil?
      # flash[:notice] = "Your record is already there"
      redirect_to new_user_path
    else
      redirect_to users_path
    end
  end
  
end
