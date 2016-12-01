class StudentRequestsController < ApplicationController
  
  include SessionHelper
  
  ###The following line is commented right now because the service is not registered with CAS.
  ### Once our service will be registered with CAS, we will uncomment this and handle session.
  
  # before_filter CASClient::Frameworks::Rails::Filter
  
  def student_request_params
    params.require(:student_request).permit(:request_id, :uin, :full_name, :major , :classification, :minor, :email, :phone, :expected_graduation, :request_semester, :course_id, :section_id, :notes, :state )
  end

  def index
    if session_get(:uin) == nil
      redirect_to root_path
    else
      @student_requests = StudentRequest.where(:uin => session_get(:uin))
    end
  end

  def new
    # default: render 'new' template
    initForNewForceRequest
    render :new
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
      flash[:warning] = @student_request.errors.full_messages.join(", ")
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
    if session_get(:uin) == nil
      redirect_to root_path
    else
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
  end
  
  def updaterequestbyadmin
    isUpdated = false 
    @student_request = StudentRequest.find params[:id]
    if(StudentRequest::STATES_AVAILABLE_TO_ADMIN.include? params[:state])
      @student_request.state = params[:state]
      isUpdated = true
    end
    if(StudentRequest::PRIORITY_LIST.include? params[:priority])
       @student_request.priority = params[:priority]
       isUpdated = true
    end
      
    unless params[:notes_for_myself].nil?
      @student_request.admin_notes = params[:notes_for_myself]
      isUpdated = true
    end
    unless params[:notes_for_student].nil?
      @student_request.notes_to_student = params[:notes_for_student]
      isUpdated = true
    end
    
    if(isUpdated)
      @student_request.save!
      flash[:notice] = "The " + @student_request.request_id + " request was successfully updated"
    else 
      flash[:warning] = "Please Select Appropriate action " 
    end
   
    redirect_to student_requests_adminview_path
  end

  def login
    session_update(:current_state, nil)
    if params[:session][:uin] =~ /^\d+$/
      session_update(:uin, params[:session][:uin])
      
      if Admin.exists?(:uin => session_get(:uin))
        session_update(:current_state, "admin")
        redirect_to student_requests_adminview_path
      else
        session_update(:current_state, "student")
        redirect_to student_requests_path
      end
    else
      flash[:warning] = "Invalid UIN format"
      redirect_to root_path
    end
  end
  
  def homeRedirect
    @currentstate = session_get(:current_state)
    if @currentstate == "admin"
      redirect_to student_requests_adminview_path
    elsif @currentstate == "student"
      redirect_to student_requests_path
    else
      redirect_to root_path
    end
  end
  
  def logout
    session_remove
    session_update(:current_state, nil)
    redirect_to root_path
  end
  
  def getSpreadsheet
    @student_by_course = StudentRequest.where(course_id: params[:course_id])
    respond_to do |format|
    format.csv { send_data @student_by_course.to_csv, :filename => params[:course_id]+".csv" }
    end
  end
  
  def getSpreadsheetAllCourses
    @student = StudentRequest.all
    respond_to do |format|
    format.csv { send_data @student.to_csv, :filename => "All_force_requests"+".csv" }
    end
  end
    
  def getStudentInformationByUin
    @student_by_uin = StudentRequest.where(uin: params[:uin])
  end

  def multiupdate
    if (params[:request_ids] != nil)
      isUpdate = false
      params[:request_ids].each { |id|
        @student_request = StudentRequest.find id
        if(params[:multi_state_sel] != "Select State")
          isUpdate = true
          @student_request.state = params[:multi_state_sel]
          @student_request.save!
        end
        if(params[:multi_priority_sel] != "Select Priority")
          isUpdate = true
          @student_request.priority = params[:multi_priority_sel]
          @student_request.save!
        end
      }
      if(isUpdate)
        flash[:notice] = "Requests has been updated"
      else
        flash[:warning] = "No State or Priority Selected"
      end
    else
      flash[:warning] = "Nothing has been selected for Update"
    end
    redirect_to student_requests_adminview_path
  end
  
  def initForNewForceRequest
    @classificationList = StudentRequest::CLASSIFICATION_LIST
    @YearSemester = StudentRequest::YEAR_SEMESTER
    @requestSemester = StudentRequest::REQUEST_SEMESTER
    @majorList = Major.pluck(:major_id)
  end
  
  def adminprivileges
    
  end
  
  def addadmin
    admin_request_params = {:uin => params[:admin_request][:uin]}
    @admin_request = Admin.new(admin_request_params)
    if @admin_request.save
      flash[:notice] = "Admin was successfully created."
      redirect_to student_requests_adminview_path
    else
      flash[:warning] = @admin_request.errors.full_messages.join(",")
      redirect_to student_requests_adminview_path
    end
      
  end
  
  def getStudentInformationById
    @allAdminStates = ["Select State",StudentRequest::APPROVED_STATE, StudentRequest::REJECTED_STATE, StudentRequest::HOLD_STATE]
    @allPriorityStates = ["Select Priority",StudentRequest::VERYHIGH_PRIORITY, StudentRequest::HIGH_PRIORITY, StudentRequest::NORMAL_PRIORITY, StudentRequest::LOW_PRIORITY, StudentRequest::VERYLOW_PRIORITY]
    @student_by_id =  StudentRequest.where(request_id: params[:id])
  end
  
  def deleteall
    @student_requests = StudentRequest.all.as_json
    @student_requests.each do |record|
      record.delete('id')
      StudentRequestArchival.create!(record)
    end
    StudentRequest.delete_all
    redirect_to student_requests_adminview_path
  end
end