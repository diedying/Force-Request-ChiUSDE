class StudentRequestsController < ApplicationController

  def student_request_params
    params.require(:student_request).permit(:request_id, :uin, :full_name, :major , :classification, :minor, :email, :phone, :expected_graduation, :request_semester, :course_id, :section_id, :notes)
  end

#   def show
#     id = params[:id] # retrieve movie ID from URI route
#     @movie = Movie.find(id) # look up movie by unique ID
#     # will render app/views/movies/show.<extension> by default
#   end

  def index
    @student_requests = StudentRequest.all
  end


  def new
    # default: render 'new' template
  end
  
  
  def cancel
    
  end

  def create
    @student_requests = StudentRequest.create!(student_request_params)
    flash[:notice] = "#{@student_requests.name} was successfully created."
    redirect_to student_requests_path
  end

#   def edit
#     @movie = Movie.find params[:id]
#   end

#   def update
#     @movie = Movie.find params[:id]
#     @movie.update_attributes!(movie_params)
#     flash[:notice] = "#{@movie.title} was successfully updated."
#     redirect_to movie_path(@movie)
#   end

#   def destroy
#     @movie = Movie.find(params[:id])
#     @movie.destroy
#     flash[:notice] = "Movie '#{@movie.title}' deleted."
#     redirect_to movies_path
#   end

end
