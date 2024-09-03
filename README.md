# book-buddy
### Purpose
The purpose of this project is to have a highly-scalable book-listing application that can be set up without much hassle.

It's a custom request by a friend for a book site for a specific purpose, but you're welcome to use it if you'd like.

### Current state
Working:

- Have a basic TF AWS acount setup for HTTPS traffic through an ALB to the application server - confirmed working~

Not working:

- No database setup at the moment, need to add a pg backend

- No working web application at the moment - just a stupid http response router, need to add routing logic for APIs, basic web routes, etc

- No working web frontend at the moment - need to add React front-end to make API calls to the web router / DB


### Infrastructure
The Book-Buddy infrastructure is laid out in the `terraform` directory.

Currently, I'm relying on defaults in the existant directories for testing. Later on, there will be parent modules calling the child modules, which I will detail here.

### Application
The Book-Buddy application is currently in development. I expect the stack to look like:

App server backend  : Go (plain http backend)

Database            : PostgreSQL

Web frontend        : ReactJS / Redux

### License
MIT License
