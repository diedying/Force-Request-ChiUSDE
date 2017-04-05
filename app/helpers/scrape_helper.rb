module ScrapeHelper
    def scrape_info(searchKey, realEmail)
        require 'rubygems'
        require 'nokogiri'
        require 'open-uri' 

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
        end
        #if there is not matched record return nil
        record = {}
        return record
    end
end