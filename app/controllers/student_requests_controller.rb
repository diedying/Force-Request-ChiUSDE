class StudentRequestsController < ApplicationController

  include SessionHelper
  include ScrapeHelper
  ###The following line is commented right now because the service is not registered with CAS.
  ### Once our service will be registered with CAS, we will uncomment this and handle session.

  # before_filter CASClient::Frameworks::Rails::Filter

  def student_request_params
    params.require(:student_request).permit(:request_id, :uin, :name, :major , :classification, :minor, :email, :phone, :expected_graduation, :request_semester, :course_id, :section_id, :notes, :state )
  end

  def index
  end

  def new
    # default: render 'new' template
    @students = Student.where(:uin => session_get(:uin))
    initForNewForceRequest
    render :new
  end

  def add_force_request #create force requests by admin
    @students = Student.where(:uin => params[:admin_request][:uin])
    if @students[0].nil?
      flash[:warning] = 'Student of UIN doesn\'t exist in system, please add him first!'
      redirect_to student_requests_adminprivileges_path
    else
      student_request_params_with_uin = {:uin => params[:admin_request][:uin], :name  => @students[0].name, :major => @students[0].major,
                                        :email => @students[0].email, :classification => @students[0].classification}
      student_request_params_with_uin.merge!(student_request_params)#update the session[:uin] to :uin in student_request
      @student_request = StudentRequest.new(student_request_params_with_uin)
      @student_request.state = StudentRequest::ACTIVE_STATE
      @student_request.priority = StudentRequest::NORMAL_PRIORITY
      if @student_request.save
        flash[:notice] = "Student Request was successfully created."
        redirect_to student_requests_adminprivileges_path
      else
        flash[:warning] = @student_request.errors.full_messages.join(", ")
        initForNewForceRequest
        redirect_to student_requests_adminprivileges_path
      end
    end
  end

  def create  #create force requests by student
    @students = Student.where(:uin => session_get(:uin))
    student_request_params_with_uin = {:uin => session[:uin], :name  => @students[0].name, :major => @students[0].major,
                                        :email => @students[0].email, :classification => @students[0].classification}
    student_request_params_with_uin.merge!(student_request_params)#update the session[:uin] to :uin in student_request
    if StudentRequest.exists?(:uin => session_get(:uin), :course_id => params[:student_request][:course_id], :section_id => params[:student_request][:section_id])
        flash[:warning] = "You have already submitted a force request for CSCE" +  params[:student_request][:course_id] + "-" + params[:student_request][:section_id]
        initForNewForceRequest
        render :new
    else
        @student_request = StudentRequest.new(student_request_params_with_uin)
        @student_request.state = StudentRequest::ACTIVE_STATE
        @student_request.priority = StudentRequest::NORMAL_PRIORITY

        if @student_request.save
          flash[:notice] = "Student Request was successfully created."
          # This is where an email will be sent to comfirm the force request.
          StudentMailer.confirm_force_request(@students[0], @student_request).deliver
          redirect_to students_show_path
        else
          flash[:warning] = @student_request.errors.full_messages.join(", ")
          initForNewForceRequest
          render :new
        end
    end

  end

  def update
    unless params[:id].nil?
      @student_request = StudentRequest.find params[:id]
      if @student_request.state == StudentRequest::ACTIVE_STATE
        @student_request.state = StudentRequest::WITHDRAWN_STATE
        @student_request.destroy
        flash[:notice] = "Student Request was successfully withdrawn."
      else
        flash[:warning] = "Student Request cannot be withdrawn."
      end
      redirect_to students_show_path
    end
  end

  def edit
  end

  def approve
    @student_request = StudentRequest.find params[:id]
    @student_request.state = StudentRequest::APPROVED_STATE
    @student_request.save
    redirect_to student_requests_adminview_path
  end

  def reject
    @student_request = StudentRequest.find params[:id]
    @student_request.state = StudentRequest::REJECTED_STATE
    @student_request.save
    redirect_to student_requests_adminview_path
  end

  
  def hold
    @student_request = StudentRequest.find params[:id]
    @student_request.state = StudentRequest::HOLD_STATE
    @student_request.save
    redirect_to student_requests_adminview_path
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
      @allViewAdminStates = [StudentRequest::ACTIVE_STATE,StudentRequest::APPROVED_STATE, StudentRequest::REJECTED_STATE, StudentRequest::HOLD_STATE]
      @allPriorityStates = ["Select Priority",StudentRequest::VERYHIGH_PRIORITY, StudentRequest::HIGH_PRIORITY, StudentRequest::NORMAL_PRIORITY, StudentRequest::LOW_PRIORITY, StudentRequest::VERYLOW_PRIORITY]

      @allcourses = StudentRequest.select(:course_id).map(&:course_id).uniq
      @coursestudentlist = Hash.new

      @allcourses.each do |course|
        @students = StudentRequest.where(course_id: course).where.not(state: StudentRequest::WITHDRAWN_STATE)
        @students = @students.reject{ |s| @state_selected[s.state] == false}
        @students = @students.reject{ |s| @priority_selected[s.priority] == false}
        @coursestudentlist[course] = @students
      end
      @allcourses = @allcourses.sort
    end
  end

  def updaterequestbyadmin
    isUpdated = false
    @student_request = StudentRequest.find params[:id]
    if(@student_request.state == StudentRequest::WITHDRAWN_STATE)
      flash[:warning] = "Request has already been withdrawn by student. Please refresh your Page."
    else
      if(StudentRequest::STATES_AVAILABLE_TO_ADMIN.include? params[:state])
        @student_request.state = params[:state]
        isUpdated = true
      end
      if(StudentRequest::PRIORITY_LIST.include? params[:priority])
         @student_request.priority = params[:priority]
         isUpdated = true
      end

      unless params[:notes_for_myself].nil? or params[:notes_for_myself].empty?
        @student_request.admin_notes = params[:notes_for_myself]
        isUpdated = true
      end
      unless params[:notes_for_student].nil? or params[:notes_for_student].empty?
        @student_request.notes_to_student = params[:notes_for_student]
        isUpdated = true
      end

      if(isUpdated)
        @student_request.save!
        flash[:notice] = "The " + @student_request.request_id + " request was successfully updated"
      else
        flash[:warning] = "Please Select Appropriate action "
      end
    end

    redirect_to student_requests_adminview_path
  end

  #login for students and admin
  def login
    session_update(:current_state, nil)
    #first, check the current user is student or admin
    if params[:session][:user] == 'admin'
        #check if the uin of admin is valid
          @cur_user = Admin.where("email ='#{params[:session][:email]}' and password ='#{params[:session][:password]}'")
          if @cur_user[0].nil?
            flash[:warning] = "Your UIN or Password is WRONG!"
            redirect_to root_path
          else
            #update the session value which could be used in other pages
            session_update(:name, @cur_user[0][:name])
            #:current_state could indicate the current user is admin or student
            session_update(:current_state, "admin")
            session_update(:uin, @cur_user[0][:uin])
            redirect_to student_requests_adminview_path
          end
    elsif params[:session][:user] == 'student'
      #check if the uin of student is valid
        @user = Student.where("email = '#{params[:session][:email]}'")
        if @user[0].nil?#the user doesn't sign up
            flash[:warning] = "The account doesn't exsit. Please sign up first."
            redirect_to root_path
            return#tricky
        end
        @cur_user = Student.where("email ='#{params[:session][:email]}' and password ='#{params[:session][:password]}'")
        if @cur_user[0].nil?#the UIN or Password don't match
          flash[:warning] = "Entered UIN and Password didn't match. Try again."
          redirect_to root_path
        else
          # check if the current student activate his account
          if @cur_user[0].email_confirmed
            #update the session value which could be used in other pages
            session_update(:name, @cur_user[0][:name])
            session_update(:current_state, "student")
            session_update(:uin, @cur_user[0][:uin])
            redirect_to students_show_path
          else
            flash[:warning] = "The account has not been activate. Please check your email to activate your account!"
            redirect_to root_path
          end
        end

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
        if(@student_request.state == StudentRequest::WITHDRAWN_STATE)
          flash[:warning] = "Student has already withdraw his request"
        else
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
        end
      }
      if(isUpdate)
        if(flash[:warning].nil?)
          flash[:notice] = "Requests have been updated"
        else
          flash[:notice] = "Some Requests have been updated"
        end
      else
        if(flash[:warning].nil?)
          flash[:warning] = "No State or Priority Selected"
        end
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
    if session_get(:uin) == nil
      redirect_to root_path
    end
    initForNewForceRequest
  end

  # def addadmin
  #   admin_request_params = {:uin => params[:admin_request][:uin],
  #                           :name => params[:admin_request][:name],
  #                           :password => params[:admin_request][:password]}
  #   @admin_request = Admin.new(admin_request_params)
  #   if @admin_request.save
  #     flash[:notice] = "Admin was successfully created."
  #     redirect_to student_requests_adminview_path
  #   else
  #     flash[:warning] = @admin_request.errors.full_messages.join(",")
  #     redirect_to student_requests_adminview_path
  #   end
  # end

  # def add_student
  #   @classificationList = StudentRequest::CLASSIFICATION_LIST
  #   @majorList = Major.pluck(:major_id)
  #   if params[:session][:uin2] == params[:session][:uin]
  #     @students = Student.where("uin = '#{params[:session][:uin]}'")
  #     if @students[0].nil?
  #       #if scrape_info(params[:session][:name], params[:session][:email]) != {}
  #         # record = scrape_info(params[:session][:name], params[:session][:email])
  #         @newStudent = Student.create!(:name => params[:session][:name], :uin => params[:session][:uin], :email => params[:session][:email], :password => params[:session][:password],
  #                                             :major => params[:session][:major], :classification => params[:session][:classification])
  #         flash[:notice] = "Name:#{@newStudent.name}, UIN: #{@newStudent.uin}, Email: #{@newStudent.email} signed up successfully."
  #         redirect_to student_requests_adminprivileges_path
  #       #else
  #         #flash[:notice] = "Student information is incorrect!\nPlease use TAMU email!\nUse name as which is on Student ID!"
  #         #redirect_to student_requests_adminprivileges_path
  #       #end
  #     else
  #       flash[:notice] = "Student record is already there"
  #       redirect_to student_requests_adminprivileges_path
  #     end
  #   else
  #     flash[:notice] = "The twice entered UIN must be same!"
  #     redirect_to student_requests_adminprivileges_path
  #   end
  # end


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
  def cancel
  end

  def add_new_force_request
    initForNewForceRequest
  end
end
