class StudentsController < ApplicationController
    def scrape_info(searchKey, realEmail)
        require 'rubygems'
        require 'nokogiri'
        require 'open-uri' 
        #the user input (name and email) we could get from the sign up page
        ###################################
        #There is tricky case: some person has change his email address, but the search database doesn't change
        #searchKey = 'haoran+wang'
        #realEmail = 'haoranwang@tamu.edu'
        ###################################
        #pre-proccessing the searchKey, there seems no need to do pre-proccessing
        #because even if there is whitespace, we could also use the searchKey to the url

        #get the search url of specific searchKey
        urlSearch = 'https://services.tamu.edu/directory-search/?branch=people&cn=' + searchKey
        page = Nokogiri::HTML(open(urlSearch))
        table = page.css('table#resultsTable')
        urlPersons = table.css('a')#store the all searched results url
        #check all searched records to find out the one we need
        #use the realEmail to match
        urlPersons.each do |url|
            urlPerson =  'https://services.tamu.edu' + url['href']
	        personPage = Nokogiri::HTML(open(urlPerson))

	        ths = personPage.css('table').css('th')
	        tds = personPage.css('table').css('td')
	        #record is a hash table to store the all information of the current searched record
	        record = {}
	        for i in 0...ths.length do
		        th = ths[i].text[0...-1]
		        record[th] = tds[i].text
	        end
	        
	        #if the Email matches the realEmail, output the result and break the loop
    	    if record['Email Address'] == realEmail
    	        return record
    	    end
        end
        #if there is not matched record return nil
        record = {}
        return record
    end
    
    def signup
    end
    #create a new student record
    def create
        if params[:session][:uin2] == params[:session][:uin] and params[:session][:password2] == params[:session][:password]
            @student = Student.where("name ='#{params[:session][:name]}' and email ='#{params[:session][:email]}' and password ='#{params[:session][:password]}'")
            if @student[0].nil?
                if scrape_info(params[:session][:name], params[:session][:email]) != {}
                    record = scrape_info(params[:session][:name], params[:session][:email]) 
                    @newStudent = Student.create!(:name => record['Name'], :uin => params[:session][:uin], :email => record['Email Address'], :password => params[:session][:password] )
            
            # @newStudent = Student.create!(:name => params[:session][:name], :uin => params[:session][:uin], :email => params[:session][:email], :password => params[:session][:password] )
                    flash[:notice] = "#{@newStudent.name} #{@newStudent.email} #{@newStudent.uin} signed up successfully."
                    redirect_to root_path
                else
                    flash[:notice] = "Please sign up with your TAMU Email!"
                    redirect_to students_signup_path
                    
                end
            else
                flash[:notice] = "Your record is already there"
                redirect_to root_path
            end
             
        else
            flash[:notice] = "Your UIN or password is not same!"
            redirect_to students_signup_path
        end
        
    end
    
end