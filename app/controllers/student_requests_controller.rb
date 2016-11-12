class StudentRequestsController < ApplicationController
  
  include Session_Helper
  
  ###The following line is commented right now because the service is not registered with CAS.
  ### Once our service will be registered with CAS, we will uncomment this and handle session.
  
  # before_filter CASClient::Frameworks::Rails::Filter
  
  def student_request_params
    params.require(:student_request).permit(:request_id, :uin, :full_name, :major , :classification, :minor, :email, :phone, :expected_graduation, :request_semester, :course_id, :section_id, :notes, :state )
  end

  def index
    @student_requests = StudentRequest.where(:uin => session_get(:uin))
  end

  def new
    # default: render 'new' template
    initForNewForceRequest
  end

  def create
    student_request_params_with_uin = {:uin => session[:uin]}
    student_request_params_with_uin.merge!(student_request_params)
    @student_request = StudentRequest.new(student_request_params_with_uin)
    @student_request.state = StudentRequest::ACTIVE_STATE
    @student_request.priority = StudentRequest::NORMAL_PRIORITY
    if @student_request.save
      flash[:notice] = "Student Request was successfully created."
      redirect_to student_requests_path
    else
      flash[:warning] = @student_request.errors.full_messages.join(",")
      initForNewForceRequest
      render :new
    end
  end
  
  def update
    unless params[:id].nil?
      @student_request = StudentRequest.find params[:id]
      if @student_request.state == StudentRequest::ACTIVE_STATE
        @student_request.state = StudentRequest::WITHDRAWN_STATE
        @student_request.save!
        flash[:notice] = "Student Request was successfully withdrawn."
      else
        flash[:warning] = "Student Request cannot be withdrawn."
      end
      redirect_to student_requests_path
    end
  end
  
  def edit
  end


  # def destroy
  #   @student_request = StudentRequest.find(params[:id])
  #   @student_request.destroy
  #   flash[:notice] = "Request '#{@student_request.request_id}' deleted."
  #   redirect_to student_requests_path
  # end
  
  def adminview
    @state_selected = {}
    @priority_selected = {}
    @all_priorities = [StudentRequest::VERYHIGH_PRIORITY, StudentRequest::HIGH_PRIORITY, StudentRequest::NORMAL_PRIORITY, StudentRequest::LOW_PRIORITY, StudentRequest::VERYLOW_PRIORITY]
    @all_states = [StudentRequest::ACTIVE_STATE, StudentRequest::REJECTED_STATE, StudentRequest::APPROVED_STATE, StudentRequest::HOLD_STATE]
    @default_states = [StudentRequest::ACTIVE_STATE, StudentRequest::HOLD_STATE]
    if params[:state_sel] == nil
      if session_get(:state_sel) != nil
        @all_states.each { |state|
          @state_selected[state] = session_get(:state_sel).has_key?(state)
        }
      else
        @all_states.each { |state|
          @state_selected[state] = @default_states.include?(state)
        }
      end
    else
      @all_states.each { |state|
        @state_selected[state] = params[:state_sel].has_key?(state)
      }
      session_update(:state_sel, params[:state_sel])
    end
  
    if params[:priority_sel] == nil
      if session_get(:priority_sel) != nil
        @all_priorities.each { |priority|
          @priority_selected[priority] = session_get(:priority_sel).has_key?(priority)
        }
      else
        @all_priorities.each { |priority|
          @priority_selected[priority] = @all_priorities.include?(priority)
        }
      end
    else
      @all_priorities.each { |priority|
        @priority_selected[priority] = params[:priority_sel].has_key?(priority)
      }
      session_update(:priority_sel, params[:priority_sel])
    end
    
    @allAdminStates = ["Select State",StudentRequest::APPROVED_STATE, StudentRequest::REJECTED_STATE, StudentRequest::HOLD_STATE]
    @allPriorityStates = ["Select Priority",StudentRequest::VERYHIGH_PRIORITY, StudentRequest::HIGH_PRIORITY, StudentRequest::NORMAL_PRIORITY, StudentRequest::LOW_PRIORITY, StudentRequest::VERYLOW_PRIORITY]
   
    @allcourses = StudentRequest.select(:course_id).map(&:course_id).uniq
    @coursestudentlist = Hash.new
   
    @allcourses.each do |course|
      @students = StudentRequest.where(course_id: course).where.not(state: StudentRequest::WITHDRAWN_STATE)
      @students = @students.reject{ |s| @state_selected[s.state] == false}
      @students = @students.reject{ |s| @priority_selected[s.priority] == false}
      @coursestudentlist[course] = @students
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
    #session[:uin] = params[:session][:uin]
    session_update(:uin, params[:session][:uin])
    list_of_admin_uins = ['123', '234', '345']
    if list_of_admin_uins.include? session_get(:uin)
      redirect_to student_requests_adminview_path
    else
      redirect_to student_requests_path
    end
  end
  
  def logout
    #session[:uin] = nil
    session_removeDel(0)
    redirect_to root_path
  end
  
  def getSpreadsheet
    @student_by_course = StudentRequest.where(course_id: params[:course_id])
    respond_to do |format|
    format.csv { send_data @student_by_course.to_csv, :filename => params[:course_id]+".csv" }
    end
  end
  
  def getStudentInformationByUin
    @student_by_uin = StudentRequest.where(uin: params[:uin])
  end

  def multiupdate
    if (params[:request_ids] != nil)
      params[:request_ids].each { |id|
        @student_request = StudentRequest.find id
        if(params[:multi_state_sel] != "Select State")
          @student_request.state = params[:multi_state_sel]
          @student_request.save!
        end
        if(params[:multi_priority_sel] != "Select Priority")
          @student_request.priority = params[:multi_priority_sel]
          @student_request.save!
        end
      }
    end
    redirect_to student_requests_adminview_path
  end
  
  def initForNewForceRequest
    @classificationList = StudentRequest::CLASSIFICATION_LIST
    @YearSemester = StudentRequest::YEAR_SEMESTER
    @requestSemester = StudentRequest::REQUEST_SEMESTER
  end
  
  def getStudentInformationById
    @allAdminStates = ["Select State",StudentRequest::APPROVED_STATE, StudentRequest::REJECTED_STATE, StudentRequest::HOLD_STATE]
    @allPriorityStates = ["Select Priority",StudentRequest::VERYHIGH_PRIORITY, StudentRequest::HIGH_PRIORITY, StudentRequest::NORMAL_PRIORITY, StudentRequest::LOW_PRIORITY, StudentRequest::VERYLOW_PRIORITY]
    @student_by_id =  StudentRequest.where(request_id: params[:id])
  end
end