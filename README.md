Welcome to Force Request System!
===================


The Department of Computer Science and Engineering(CSE) at Texas A&M University needed a new system to manage force requests for different courses offered by the department. A force request is a special kind of request submitted by a student to register for a course which is filled up to its current limit. The advisors prioritize the request based on certain parameters (such as the department of the student, major/minor of the student and expected year of graduation) and handle these requests by accepting or rejecting it. The newly developed Force Request System henceforth called as FRS, is a standalone web application, which includes the functionality of the previous system, part of CSnet. We have two stakeholders of this web application. One is the student and other the administrator.

----------


Developers
-------------

Adil Hamid Malla 
Aditya Nanjangud 
Bhavik Ameta 
Navneet Gupta 
Shubham Jain

#### <i class="icon-file"></i> Steps to start the Force Request System:-

bundle install
:   Install the dependencies specified in your Gemfile

sudo service postgresql start
:   Start the postgres server

psql

:   Connect to the postgres service                        
:    \password ubuntu ---> Set password for 'ubuntu' user to 'ubuntu'

rake db:setup
:   Creates all the tables i.e. runs the /db/schema.rb file

rake db:seed
:   Add the dummy data to the database

rails s \-p \$PORT -b $IP
:   Starts the rails application




#### <i class="icon-folder-open"></i> Note

For seeing the admin view, simply give admin UIN. For testing purpose, UIN are mentioned in seeds.rb. All other UINs are by default considered for students.
