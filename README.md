## Adopt Don't Shop Paired

"Adopt Don't Shop Paired" is a fictitious pet adoption platform where visitors can favorite pets and apply to adopt their newest furry friend. This project was completed in a pair by [Daniel Halverson](https://github.com/dhalverson) and [Garrett Gerdsen](https://github.com/ggerdsen)

This project built off of Garrett's solo project repo from week 1 of Module 2, Adopt Don't Shop.

## Project Requirements

Requirements included the use of:
- Rails 5.2.4.3
- PostgreSQL
- Complete model and feature testing coverage
- GitHub branches, pull requests and reviews
- Readme

### Overview

  This was a continuation of the Mod 2, week 1 solo project Adopt Don't Shop, as a paired partner project. We utilized many to many relationships, joins tables, active record querying, session data, Rspec Test Driven Development, the HTML request and response cycle, MVC and RESTful conventions, and basic HTML and CSS styling.
  
  The Pet Index page shows a list of all the available pets and their information, including a link to which shelter they are currently located at. Users are also able to update or delete a pet from this page. If you click into a pet's show page, you are able to favorite or remove from favorites, which will allow you to submit an application to adopt this pet.
  
  The Shelter Index page shows a list of all the pet shelters. You can click each shelter to view it's pets, as well as update and delete shelters from this page. You also have the ability to create new shelters from this pae, which will show up automatically once created. Each shelter's show page contains information about the shelter, some statistics, the ability to create and view reviews, as well as update the information, or view the pets.

  The Favorites page will show any favorites that you have selected for your session, and allow you to submit an application for them using the "Adopt My Favorites" link. This link will take you to a form to submit an application, which can be approved or revoked at a later point.
  
 ## Learning Goals
 
 Some learning/growth goals for this project were:
 
 ### Rails
 - Follow MVC and RESTful convention to organize code and logic effectively
 - Use PORO's for objects not stored in our Database
 - Effective use of Flash messages to alert the user to conditions
 
 ### Active Record
 - Use Active Record methods over Ruby for our logic
 
 ### Rspec
 - Built complete testing to ensure our application functions correctly
 - Test both models and features of our application
 - Understand Capybara and Shoulda-matchers testing syntax
 
## Challenges
- Interacting with many to many relationships and joins tables
- MVC convention and handling logic correctly
- Active Record and Rails syntax and "magic"
- Rspec testing and Shoulda-matchers syntax
- Finding, selecting, and matching objects and ID's across tables and actions

## Built With

- Rails 5.2.4.3
- PostgreSQL
- Postico
- Capybara
- Shoulda-matchers
- Simplecov
- Rspec-rails


