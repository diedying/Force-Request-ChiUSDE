class AdminsController < ApplicationController
    include SessionHelper
    include ScrapeHelper
    
  def addAdmin
    admin_request_params = {:uin => params[:admin_request][:uin],
                            :name => params[:admin_request][:name],
                            :password => params[:admin_request][:password]}
    @admin_request = Admin.new(admin_request_params)
    if @admin_request.save
      flash[:notice] = "Admin was successfully created."
      redirect_to student_requests_adminview_path
    else
      flash[:warning] = @admin_request.errors.full_messages.join(",")
      redirect_to student_requests_adminview_path
    end
  end
  
  
  
  
end