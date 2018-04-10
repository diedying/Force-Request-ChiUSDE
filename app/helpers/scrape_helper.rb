module ScrapeHelper
    def scrape_info(lastName, firstName, major, realEmail)
        require 'rubygems'
        require 'nokogiri'
        require 'open-uri' 

        #split_name = name.split(/, */)
        #lastName = split_name[0]
        #firstName = split_name[1]

        
        
        # Old pattern for name in signup.html.haml: :pattern => "[a-zA-ZüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]{3,}"

        #get the search url of specific name / major
        urlSearch = 'https://services.tamu.edu/directory-search/?branch=people&givenName=' + firstName + '&sn=' + lastName + '&tamuEduPersonMajor=' + major + '#adv-search'
        page = Nokogiri::HTML(open(urlSearch))
        
        # https://stackoverflow.com/questions/4232345/get-div-nested-in-div-element-using-nokogiri
            
        results = page.css('div.floating-form.u-radiusTop--0')
        record = {}
           
           
        temp = results[0].css('p.alert__title')
        if temp.text == "No search results were found."
            return record
        end
        
        # Iterate through results matching the person's name
        # If we find a result with a matching email, return that record
        # Otherwise, return a blank result.
            
        results.each do |result|
            profileLink = result.css('li.view-profile a[href]').attr('href')
            urlPerson =  'https://services.tamu.edu' + profileLink
            puts('URL: ', urlPerson)
            # Only open the page if it's a student (ignore faculty for now).
            # TODO: result['class'] returns floating-form.u-radiusTop--0
            #if result['class'] == '.result-listing student'
            personPage = Nokogiri::HTML(open(urlPerson))
            # Get the classification from the directory's person page
            additionalInfo = personPage.css('.additional-info').css('ul')
            classification = additionalInfo.css('li')[0].text
            puts("*************************")
            puts(major)
            puts("*************************")
            # Get the email address from the directory's person page
            contactInfo = personPage.css('.contact-info')
            pageEmail = contactInfo.css('a').text
            # Compare the page's email to the entered email
            classification = classification[15,2]
            if classification == "Fr"
                classification = "U1"
            else if classification == "So"
                classification = "U2"
            else if classification == "Ju"
                classification = "U3"
            else if classification == "Se"
                classification = "U4"
            else
                classification = classification
            end
            
            
            if pageEmail == realEmail
                record['First Name'] = firstName
                record['Last Name'] = lastName
                record['Email Address'] = realEmail
                record['Major'] = major
                record['Classification'] = classification[15,2]
                break
            end
            #end
        end
        return record
        # end
    end
end
=begin
        urlPersons = result.css('a')#store the all searched results url
        #check all searched records to find out the one we need
        #use the realEmail to match
        count = 0#set the threshold for search results
        urlPersons.each do |url|
            count += 1
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
    	       # preprocess the scraped name in format of last name and first name
    	        if record['Name'].include?(',')
    	            split_name = record['Name'].split(/, */)
    	            record['Last Name'] = split_name[0]
    	            record['First Name'] = split_name[1]
    	        else
    	            record['Last Name'] = record['Name'].split.last
    	            record['First Name'] = record['Name'].split.first
    	        end
    	        return record
    	    end
    	    if count > 30
    	        break
    	    end 
        end
        #if there is not matched record return nil
        record = {}
        return record
    end
end
=end