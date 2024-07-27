# book-buddy
### Purpose
The purpose of this project is to have a highly-scalable book-listing application that can be set up without much hassle.

### Infrastructure
The Book-Buddy infrastructure is laid out in the `terraform` directory. Currently, I'm relying on defaults in the existant directories for testing. Later on, there will be parent modules calling the child modules, which I will detail here.

### Application
The Book-Buddy application is currently in development. I expect the stack to look like:
App server backend  : Go (gin)
Database            : PostgreSQL
Web frontend        : ReactJS / Redux

### License
MIT License
