class StudentRequestsController < ApplicationController

  # before_filter CASClient::Frameworks::Rails::Filter
  
  def student_request_params
    params.require(:student_request).permit(:request_id, :uin, :full_name, :major , :classification, :minor, :email, :phone, :expected_graduation, :request_semester, :course_id, :section_id, :notes, :state )
  end

  # def show
  #   req = params[:request_id] # retrieve request ID from URI route
  #   @student_request = StudentRequest.find(req) # look up request by unique ID
  #   # will render app/views/student_requests/show.<extension> by default
  # end

  def index
    @student_requests = StudentRequest.all.where(:state => StudentRequest::ACTIVE_STATE)
  end


  def new
    # default: render 'new' template
  end
  
  
  def cancel
    
  end

  def create
    @student_request = StudentRequest.new(student_request_params)
    @student_request.state = StudentRequest::ACTIVE_STATE
    @student_request.save!
    flash[:notice] = "Student Request was successfully created."
    redirect_to student_requests_path
  end
  
  def update
    @student_request = StudentRequest.find params[:id]
    @student_request.state = StudentRequest::WITHDRAWN_STATE
    @student_request.save!
    flash[:notice] = "Student Request was successfully deleted."
    redirect_to student_requests_path
  end
  
  def edit
    @student_request = StudentRequest.find params[:id]
    @student_request.state = StudentRequest::WITHDRAWN_STATE
    @student_request.save!
    flash[:notice] = "Student Request was successfully deleted."
    redirect_to student_requests_path
  end


  def destroy
    @student_request = StudentRequest.find(params[:id])
    @student_request.destroy
    flash[:notice] = "Request '#{@student_request.request_id}' deleted."
    redirect_to student_requests_path
  end
  
  def allstudents
    @student_requests = StudentRequest.all
  end
end