# Little Shop of Orders, v2

BE Mod 2 Week 4/5 Group Project


## Background and Description

"Little Shop of Orders" is a fictitious e-commerce platform where users can register to place items into a shopping cart and 'check out'. Merchant users can mark items as 'fulfilled', and Admins can mark orders as 'complete'. Each user role will have access to some or all CRUD functionality for application models.

Students will be put into 3 or 4 person groups to complete the project.


## Learning Goals

- Advanced Rails routing (nested resources and namespacing)
- Advanced ActiveRecord for calculating statistics
- Average HTML/CSS layout and design for UX/UI
- Session management and use of POROs for shopping cart
- Authentication, Authorization, separation of user roles and permissions


## Requirements

- must use Rails 5.1.x
- must use PostgreSQL
- must use 'bcrypt' for authentication
- all controller and model code must be tested via feature tests and model tests, respectively
- must use good GitHub branching, team code reviews via GitHub comments, and use of a project planning tool like waffle.io
- must include a thorough README to describe their project

## Permitted

- use FactoryBot to speed up your test development
- use "rails generators" to speed up your app development

## Not Permitted

- do not use JavaScript for pagination or sorting controls

## Permission

- if there is a specific gem you'd like to use in the project, please get permission from your instructors first

---

## User Roles

1. Visitor - this type of user is anonymously browsing our site and is not logged in
2. Registered User - this user is registered and logged in to the application while performing their work; can place items in a cart and create an order
3. Merchant User - a registered user who is also has access to merchant data and operations; user is logged in to perform their work
4. Admin User - a registered user (but cannot also be a merchant) who has "superuser" access to all areas of the application; user is logged in to perform their work


## User Stories

Depending on the inning and holiday schedule, your instructors will assign one of the following story sets to you:

- [The long version](stories_long.md)
- [The short version](stories_short.md)


## Rubric, Evaluations, and final Assessment

Each team will meet with an instructor at least two times before the project is due.

- At first team progress check-in, about 33% of the work is expected to be completed satisfactorily
- At second team progress check-in, about 66% of the work is expected to be completed satisfactorily
- Final submission will expect 100% completion

Each team will have a rubric uploaded to [https://github.com/turingschool/ruby-submissions](https://github.com/turingschool/ruby-submissions)


View the [Little Shop Rubric](LittleShopRubric.pdf)
