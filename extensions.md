# Little Shop Extensions

These "extension" stories are for the final week solo project for Backend Module 2 students.

Students will need to include a minimum of 3 points of additional extension work.

1 of these extension points of work will be assigned to you. The other points you get to choose from the following list:

---

## Turing student uses a different project's team code base (counts as 1 extension point)

You will not use your group's project code to implement other extension work.

You will be assigned a code base by your instructors, and you will fork their repo and add your own work to your own repo.

You will deploy the code to your own new Heroku instance.

#### Mod 2 Learning Goals reflected:

- Understanding MVC
- Rails development (including routing)
- Understanding HTTP statelessness and sessions
- Software Testing

---

## Users can rate items (counts as 1 extension point)

Users will have the ability to leave ratings for items they have successfully purchased.

Users cannot rate items from orders which have been canceled by the user or an admin.

Users can write one rating per item per order. If the user orders an item (in any quantity) they can leave one rating. If they order the item again in a different order, the user can leave another rating.

Build all CRUD functionality for users to add a rating through their order show page.

Users can disable any rating they created. Admins can enable or disable any rating.

Disabled ratings should not factor into total counts of ratings, nor averages of ratings.

Ratings will include a title, a description, and a rating from 1 to 5.

#### Mod 2 Learning Goals reflected:

- Database relationships
- Rails development (including routing)
- Software Testing
- HTML/CSS styling and layout

---

## Slugs (counts as 1 extension point)

All paths for users and items should change from `/users/5` or `/items/17` to use "slugs" such as `/user/iandouglas` or `/items/awesome-widget-2000`

Admins have the ability to update a 'slug' for a user or item, and these `update` methods should exist under admin-only namespaced routes.

#### Mod 2 Learning Goals reflected:

- Additional database migrations
- ActiveRecord
- Rails routing
- Namespacing
- Software Testing

---

## Many merchants can sell the exact same item (counts as 2 extension points)

Multiple merchants can sell the exact same item instead of duplicating the item in the system over and over.

Items will have a base cost which any merchant can modify, and merchants will have a "mark-up" fee that they can configure as part of their merchant profile data.

When a user views an item show page, they will see every merchant who sells that item. The item price displayed to the user will be both the base cost of the item plus each merchant's respective mark-up. For example, a user wants to buy a bottle of soda and its base cost is $1. Merchant A has a mark-up of $0.50 to all of their items, and Merchant B adds a mark-up of $0.60 to all of their items. The user would see both merchant's prices on the page, and they will have an "add to cart" button next to each merchant, which puts that merchant's item into their cart.

When a user visits the item index page the prices they see will indicate how many merchants sell that item and show a range of prices like "Bottle of Soda, sold by 3 merchants, price range: $1.25 to $1.75"

#### Mod 2 Learning Goals reflected:

- MVC responsibilities
- Database relationships
- ActiveRecord
- Rails routing
- Software Testing

---

## Users have multiple addresses (counts as 1 extension point)

Users will have more than one address associated with their profile. Each address will have a nickname like "home" or "work". Users will need the ability to create/update and enable/disable the addresses.

The very first address they register with will be their "default" address. A user can select any other address to be their new "default" address.

When creating an order, the check-out process will need the user to select which of their shipping addresses to set for the order. It will show their "default" address first, and then all other addresses. This list will not include any disabled addresses.

If the user has no enabled addresses (they are all disabled) then the user cannot check out on the cart page. They will see text where the check-out button would be, telling the user that they must have one enabled address in order to check out.

While an order is still "pending" (no items have been fulfilled, or the order is not "complete" or "canceled"), the user can alter the order to select a different shipping address.

The order show page should show the correct shipping address.

#### Mod 2 Learning Goals reflected:

- Database relationships
- ActiveRecord
- Software Testing

---

## More Merchant stats, Part 1 (counts as 1 extention point)

This extension requires the "many merchants sell the same item" extention

When a merchant visits their dashboard, they see additional statistics:
- comparison of their mark-up compared to the system average mark-up
- how much of their revenue is profit

When a merchant visits their merchant items page:
- each item will show a a min/avg/max price for each item that is also sold by another merchant
- if this merchant's price is the lowest (or tied to be the lowest), the price should be colored green
- if this merchant's price is close to the average price, the price should colored orange
- if this merchan'ts price is higher than the average price, the price should be colored red

#### Mod 2 Learning Goals reflected:

- Advanced ActiveRecord
- Software Testing
- HTML/CSS layout and styling

---

## More Merchant stats, Part 2 (counts as 1 extention point)

Build a Merchant leaderboard available on "/merchants" that all users can see:

- Top 10 Merchants who sold the most items in the past month
- Top 10 Merchants who fulfilled non-cancelled orders in the past month

When logged in as a user:

- Also see top 5 merchants who have fulfilled items the fastest to my state
- Also see top 5 merchants who have fulfilled items the fastest to my city

#### Mod 2 Learning Goals reflected:

- Advanced ActiveRecord
- Software Testing
- HTML/CSS layout and styling

---

## Coupon Codes (counts as 1 extension point)

Merchants can generate one-time-use coupon codes within the system. Students will use [UUIDs](https://ruby-doc.org/stdlib-2.4.0/libdoc/securerandom/rdoc/SecureRandom.html) for the codes.

Users can enter a coupon code as part of the check-out process. They'll need a field on the cart page where they can enter the code, and a button to "apply" the coupon. The page should show a flash message whether the coupon was successful, and if it was successful the cart should show a new "line item" for the coupon showing its discount, and how it affected the grant total.

The coupon could be good for one of many scenarios:
- a total percentage discount ("10% off entire order")
- a set dollar amount ("$10 off any order") but should not allow the price to below $0.00
- a dollar amount if the cart total exceeds a value ("$10 off orders of $20 or more")

Users should be able to apply the coupon and continue adding items to their cart. The coupon is considered "used" when the user checks-out successfully.

#### Mod 2 Learning Goals reflected:

- Database relationships and migrations
- ActiveRecord
- Software Testing
- HTML/CSS layout and styling

---

## Bulk Discount (counts as 1 extension point)

Merchants can implement bulk discount rates on their inventory. When a user sets their cart quantity to a certain level, those discounts get applied. For example, a merchant might set bulk discounts this way:
- 1 to 10 of a single item, no discount
- 10 to 20 of a single item, 5% discount on that item's price
- 20+ of a single item, 10% discount on that item's price

#### Mod 2 Learning Goals reflected:

- Database relationships and migrations
- Advanced ActiveRecord
- Software Testing
- HTML/CSS layout and styling

---

## More Statistics (counts as 1 extension point)

Merchants can generate a list of email addresses for all existing users who are not disabled who have ordered items from this merchant in the past.

Merchants can generate a list of all new users who have never ordered from them before.

These lists should be downloadable CSV files -- **OR** -- implement charting JavaScript like D3, C3 or Google Charts, or find a Ruby gem that can assist.

#### Mod 2 Learning Goals reflected:

- Database relationships and migrations
- ActiveRecord
- Software Testing
- HTML/CSS layout and styling

---

## Merchant To-Do List (counts as 1 extension point)

Merchants who visit their dashboard should see a list of "to-do" tasks such as:
- fixing items which are using a palceholder image
  - each of these items will appear on the dashboard page with a link going directly to that item's edit page where they can set a new image URL
- a count of how many orders are unfulfilled and the revenue impact ("You have 5 unfulfilled orders worth $752.86")


#### Mod 2 Learning Goals reflected:

- MVC and Rails development
- Database relationships and migrations
- ActiveRecord
- Software Testing
