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
    @student_requests = StudentRequest.where(:uin => session[:uin])
  end

  def new
    # default: render 'new' template
  end
  
  
  def cancel
    
  end

  def create
    @student_request = StudentRequest.new(student_request_params)
    @student_request.state = StudentRequest::ACTIVE_STATE
    @student_request.priority = StudentRequest::NORMAL_PRIORITY
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
  
  def adminview
    @selected = {}
    @all_states = [StudentRequest::ACTIVE_STATE, StudentRequest::REJECTED_STATE, StudentRequest::APPROVED_STATE, StudentRequest::HOLD_STATE]
    @default_states = [StudentRequest::ACTIVE_STATE, StudentRequest::HOLD_STATE]
    if params[:state_sel] == nil
      @all_states.each { |state|
        @selected[state] = @default_states.include? (state)
      }
    else
      @all_states.each { |state|
        @selected[state] = params[:state_sel].has_key?(state)
      }
    end
  
    @allAdminStates = ["Select State",StudentRequest::APPROVED_STATE, StudentRequest::REJECTED_STATE, StudentRequest::HOLD_STATE]
    @allPriorityStates = ["Select Priority",StudentRequest::VERYHIGH_PRIORITY, StudentRequest::HIGH_PRIORITY, StudentRequest::NORMAL_PRIORITY, StudentRequest::LOW_PRIORITY, StudentRequest::VERYLOW_PRIORITY]
   
    @allcourses = StudentRequest.select(:course_id).map(&:course_id).uniq
    @coursestudentlist = Hash.new
   
    @allcourses.each do |course|
      @students = StudentRequest.where(course_id: course).where.not(state: StudentRequest::WITHDRAWN_STATE)
      @coursestudentlist[course] = @students.reject{ |s| @selected[s.state] == false}
    end
  end
  
  def updaterequestbyadmin
    @student_request = StudentRequest.find params[:id]
    if([StudentRequest::APPROVED_STATE, StudentRequest::REJECTED_STATE, StudentRequest::HOLD_STATE].include? params[:state] or
      [StudentRequest::VERYHIGH_PRIORITY, StudentRequest::HIGH_PRIORITY, StudentRequest::NORMAL_PRIORITY, StudentRequest::LOW_PRIORITY, StudentRequest::VERYLOW_PRIORITY].include? params[:priority])
      if(params[:state] != "Select State")
        @student_request.state = params[:state]
     end
      
      if(params[:priority] != "Select Priority")
         @student_request.priority = params[:priority]
      end
      
      @student_request.admin_notes = params[:notes_for_myself]
      @student_request.notes_to_student = params[:notes_for_student]
      @student_request.save!
      flash[:notice] = "The request was successfully updated to " + @student_request.state + " " + @student_request.priority
    else 
      flash[:notice] = "Please Select Appropriate action " 
    end
   
    redirect_to student_requests_adminview_path
  end
  
  def login
    session[:uin] = params[:session][:uin]
    list_of_admin_uins = ['123', '234', '345']
    if list_of_admin_uins.include? session[:uin]
      redirect_to student_requests_adminview_path
    else
      redirect_to student_requests_path
    end
  end
end
