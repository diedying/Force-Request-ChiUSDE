Welcome to Force Request System!
===================


The Department of Computer Science and Engineering(CSE) at Texas A&M University needed a new system to manage force requests for different courses offered by the department. A force request is a special kind of request submitted by a student to register for a course which is filled up to its current limit. The advisors prioritize the request based on certain parameters (such as the department of the student, major/minor of the student and expected year of graduation) and handle these requests by accepting or rejecting it. The newly developed Force Request System henceforth called as FRS, is a standalone web application, which includes the functionality of the previous system, part of CSnet. We have two stakeholders of this web application. One is the student and other the administrator.

----------


Developers
-------------
Leyi Hu,
Mo Li,
Minrui Wang,
Shuocun Li,
Ying Wang,
Jiechen Zhong

#### <i class="icon-file"></i> Steps to start the Force Request System:

$ bundle install
:   Install the dependencies specified in your Gemfile

$ sudo service postgresql start
:   Start the postgres server

$ psql

:   Connect to the postgres service                        
:    \password 
:   ubuntu (---> Set password for 'ubuntu' user to 'ubuntu')

$ rake db:setup
:   Creates all the tables i.e. runs the /db/schema.rb file

$ rake db:seed
:   Add the dummy data to the database

$ rails s \-p \$PORT -b $IP
:   Starts the rails application


#### <i class="icon-folder-open"></i> Student Information Retrieval

When a new student signup into FRS, the information of this user like major, email and classification are retrived from https://services.tamu.edu/directory-search/.
The searching is based on student name, and only the retrived email mathced with student input email address, the account will be successfully created.

#### <i class="icon-folder-open"></i> Note

The admin account is stored in seeds.rb. In final release, all students accounts and requests are removed from seeds.rb.
In development mode, please also use thise seeds.rb to setup dummy data.

