# README

Create a Web Based Notebook for individuals to find / create user generated executable Cheat Sheets that are input by users in a hybrid blog / code format.  

Users create problems to test themselves and share with others and are encouraged to go through "build-up" procedure where they identify a problem , create user stories / use cases , accompanying tests and implement code to exercise the test, and so forth to build an eventual solution. (Currently hard to describe). which can be exported as a working product. (repository/directory(git_bundle))

Practice Algorithms with Built in Testing (User-Submitted) / Crowd Source Tutorials / Explanations / Cheat Sheets.

Components
    1. Front End Site
    2. Lesson pages
    3. Dashboard Pages
    4. Category Pages
    5. Notes Page
    6. IDE Code Blocks = Prefillable.
    7. Code Tester / Validation
    8. Code Builder / Source Code Compiler from Code Blocks. ; Exporter
    9. Git Backend for Saving a User's code. ; Link to Github?

Services (future)
    1. User-Code Storage
    2. Code-Builder/ Unit Tester 
    3. Content Management System Tool  to build lessons through the site. 
    4. Lesson Builder 
    

Feature List:
As a <type of user>, I want <some goal> so that <some reason>.

    • User shall be presented with catch marketing index page that will draw them into using the application.
        ○ Index page shall have top-down scroller format as seen on so many sites these days
    • User shall have the option to sign up for service for them to access their own personal learning experience.
    • User shall be able to configure their learning experience through  a sign-up wizard.
    • User shall be able to configure their learning experience through  a user settings portal.
        ○ Wizard shall guide user to choosing potential topics , this serves to illustrate capabilities on the site as well as to provide a personal plan. 
    • User shall have their own Dashboard page with in-order lesson plan that shall act as their login homepage.
    • As a User I want to be able to visit a lesson plan and read the description in an easy to view format. (What Problem are we solving )
    • As a User I want to know why lessons are important to coding. (Why/When of the Problem) 
    • As a User I want to see the expectations of the problem in Code-Form such as a User Story,  an expected main execution code and a rough overview of the acceptance criteria.
    • As a User I want to be able to have a high-level overview presented to me in a easy to read manner with visuals explaining the problem I'm going to solve. (How can we solve it?) 
    • As a User I want to see Multiple possible solutions iterating from naive to optimal.
    • As a User I want to be work on each of these solutions in its own web-form code block.
    • As a User I would like to see a compiled page view as well as a focused problem view for the solution I'm currently working on so that I don't get distracted. 
    • As a User I want to be able to test my code block while I'm working on the problem to see how I'm doing.
    • As a User I want to get a report of Errors , Exceptions, and Failed Tests after I run the code test to help me debug my solution.
    • As a User I would like my Code Block to be formatted in syntax specific format based on the language I'm currently developing in to differentiate the code from supporting text.
    • As a User I would like my Code Block IDE to respond to tabs, indentation, and provide auto wraps for syntax wrapping to help develop like I would in my normal IDE
    • As a User I would like my Code Block to have keyboard input text selection and deletion in input formats / sequences common to popular text-editing code IDEs (Sublime  / Atom)
    • As a User I would like to be able to see my lesson as a compiled page view, so I can get an overview of where I'm at.
    • As a User I want to be able to compare my solutions across the lesson by compiling, building, testing, and comparing an integrated source file. Results should be output as a popup that is clear and visually appealing.
    • As a User I want to be able to download the compiled source file to my local file system. 
    • As a  User I want to be able to take notes at any time during a lesson that references my position in the lesson along with time and a possibility to add a code snippet.
    • As a User I want my in-line notes to be integrated into a Master Note page for the lesson, so that I can use it as a reference.
    • As a User I want to be able to View and Edit my Master Lesson Notes page from the browser in a Markdown format.
    • As a System Architect, I would like all the components of CodeJournal to be decoupled enough so we can move to a Microservice architecture (SOA) at any time.
    • As a System Architect, I want to be able to scale therefore all services should be RESTful.
    • As a Product Owner, I want regression / unit tests at as many levels as possible to ensure proper iterative development and allow continuous delivery.

    • Upon clicking on  a lesson, User is brought to a lesson page that shall provide an orientation to the problem.
        ○ Lesson shall have:
            § Description of the problem
            § Why its relevant to computer science.
            § How it would work if someone were to do it by hand. 
    • Lesson shall guide user through solution by expanding one section at a time. 
    • Each section shall be represented by a particular micro-problem, or naive way to solve the problem that has a particular unit test to go with it. Expectations Inputs and Outputs should be provided. 
    • Each Section shall have an IDE Section where users can put in their code , which starts with a template method perhaps
    • User shall have access to a digital notebook of their 'notes' made during their lessons.
