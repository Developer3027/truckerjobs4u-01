# TruckerJobs4U

This app is for a class a cdl recruiting company. This project will have a lot of functionality built in.

**Landing Page**

Root of the app is a landing page. Driver will first land on the landing page where they are given information about the company and what it offers. A driver can sign up for the newsletter with an email or leave contact information that will generate a lead. The lead information is emailed to the admin of the site for further processing. A user account is created with the email and driver last name. A welcome email is sent to the driver with a request to change the password and link verification to the app side.

The app will have a quick form for job placement. A detailed walk through complete with work history for job application. Job posting board. Blog and Newsletter archive sections. Store link or e-commerce portal. Drivers have profile of work history and job application status. Recruiter have portal to allow chat with drivers, internal email, update applicants status. Some will have author status for blog, newsletter, and or job posting.

**Stage one**

Create the landing page and deploy. In stage one this is a separate part from the app. This needs to generate leads and attach to social media. This was needed yesterday. This project can be found at truckerjobs4u-00.

The app has be started as a concept and while building out the Landing page, there are ways it should have been done different. These will be considered when building the main project.

**Stage two**

Combine the app and Landing page. Use existing functionality of the landing page to continue to gain access to the app. The app can have direct access through a slightly modified url. Example: truckerjobs4u.com/app.

**Working Update**

Stage one is complete minus testing. It is very heavy and frankenstein'ed together. Have begun to correct stage one issue here. I had one page that held one form for leads and one for the newsletter. Both of these forms accepted data. I had a admin page that displayed and manipulated data from the leads and newsletters data. There was no need for everything that was created via the scaffold command and left security risks.

* In stage one I used scaffold to generate leads and the newsletter. This created a solid foundation for dealing with the data, however it grew clunky when I did not use the installed structure and built everything into the landing page.
* Here I generated the landing controller which gave me the controller and the view, then the lead and newsletter models separate which gave me the data tables I need. 
* I have wrote the create action specific for the lead model and placed the form in the landing page via a partial in the landing folder in views. Physical testing shows working in both the page and the Rails console.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
