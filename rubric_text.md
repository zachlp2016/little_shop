# Little Shop Rubric

- Evaluator:
- Team repo:
- Team Members:

Notes:

-

## Rubric Explanation

Each rubric metric below is graded on a 4-point scale:

1. Below Standard
2. Approaching Standard
3. Meets Standard
4. Above Standard


## Feature Completeness

1.
  - Fewer than 75% of the user stories are complete.
2.
  - 75% of user stories are complete, but not all of them are fully implemented
3.
  - All user stories are complete.
4.
  - All user stories are complete and additional extension work was attempted.


## MVC Responsibilities
1.
  - Views, Controllers, and Models do not have a clear sense of responsibilities.  Examples: Views are making calls to the model or making database calls.  Controllers are handling calculations, making multiple database calls, or handling presentation logic.
2.
  - Views contain logic that make significant additional calls to the database including Model class methods.
  - Controllers do a significant amount of processing of data that should exist at a model level.
  - Models process data in a way that is inefficient, or contains work that determines presentation logic. (how data might get viewed)
3.
  - Views make some calls to the database for `.each` calls and branch logic.
  - Controllers push almost all work to the Models for reading/ writing to the database.
  - Models sufficiently process and retrieve data.
4.
  - Views only display data and do not make additional calls to the database; they may include branch logic.
  - Controllers request all data from Models except `.all` or `.find` calls and only do `.create` and .`delete` methods for writing data.
  - Models read/write all other data using branch logic or smaller methods.


## Routing and Namespacing

- 1.
  - Routing is incomplete. (ie.  Missing necessary routes for functionality)
- 2.
  - Running `rake routes` shows some endpoints which do not have code implemented.
- 3.
  - Routing and namespacing are used properly for the scope of the app.
- 4.
  - Routing limits exactly which routes should be exposed for the app and nothing more.


## Testing

1.
  - Testing is below 75% or not done.
2.
  - Testing is above 75% and below 98%.
  - Tests are poorly written/unclear objective of the tests.
  - Hard coding values rather than using variables.
3.
  - 98% or better test coverage for feature.
  - 100% for model tests.
  - Using variables as opposed to hard coding values.
  - Use of within blocks for targeted feature testing.
4.
  - Very clear testdriven development.
  - Test files are extremely well organized and nested.
  - Utilize `before(:each)` blocks for sharing test setups.
  - 100% test coverage for features, and 100% of all model methods are tested.


## User Experience and Styling/Layout

1.
  - Little or no styling or layout.
  - User workflow is significantly problematic.  (unclear what routes are available or how to use the application)
2.
  - Styling is poor/ incomplete.
  - Layout does not utilize good HTML patterns.
  - Incomplete navigation for routes. (must manually type URIs)
3.
  - Purposeful styling pattern and HTML layout using the application.html.  erb file and application.css file.
  - Links/Buttons to reach all areas of the site.
4.
  - Extremely well styled and purposeful layout.
  - Excellent color scheme and font usage.
  - Easy to use and follow the application workflow. (ie. Do not have to search for links/ buttons for navigation)
  - Utilizes additional tooling, such as SCSS.


## Authentication, Authorization

1.
  - Authentication or Authorization was largely incomplete.
  - Storing passwords as strings and not using bcrypt.
2.
  - Authentication or Authorization are not implemented fully.
  - Users could impact data that they should not be permitted to access or change.
3.
  - Authentication and Authorization are implemented with clear responsibilities of each user type.
  - Proper handling of all redirects if a type of user does not have proper access.
4.
  - All areas of permitted use within the app are above and beyond what we have taught.


## Documentation and Work Flow

1.
  - No README file exists.
  - Team has not implemented any project management tool.
2.
  - README is poor quality.  (ie. No organization or flow of information.  Missing key elements, such as, how to setup the project, what the project is for, who the contributors are, etc. )
  - Team has not utilized an effective project management tool to a productive level.  (ie. User stories are not fully broken down.  Developers are not assigned cards.  Cards are not being moved effectively)
3.
  - Team README describes the application to a satisfactory level. (Includes setup, description, versioning, etc.)
  - Team has utilized a project management tool to track their work effectively and clearly.
4.
  - Team has built a robust README.  (Including screenshots of the app)
  - The team has additionally used a project management tool that clearly shows an excellent workflow to be highly productive.  (Such as automating promotion/ closing of stories as they are developed)
  - PRs also include discussions between reviewers about the code.
