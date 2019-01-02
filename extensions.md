# Little Shop Extensions

These "extension" stories are for the final week solo project for Backend Module 2 students.

Students will need to include a minimum of 2 points of additional extension work.

1 of these extension points of work will be assigned to you. The other point you get to choose from the following list:

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

The slug will need to be saved in the `users` able and `items` table, respectively.
Admins have the ability to update a 'slug' for a user or item, and these `update` methods should exist under admin-only namespaced routes.

Since user's first and last names are not unique, use their email address instead. Look into "URL encoding" for working with the `@` symbol in URI paths.

Do not use any third-party gems for this work.


#### Mod 2 Learning Goals reflected:

- Additional database migrations
- ActiveRecord
- Rails routing
- Namespacing
- Software Testing

---

## Users have multiple addresses (counts as 1 extension point)

Users will have more than one address associated with their profile. Each address will have a nickname like "home" or "work". Users will need the ability to create/update and enable/disable the addresses.

The very first address they register with will be their "default" address. A user can select any other address to be their new "default" address.

When creating an order, the check-out process will need the user to select which of their shipping addresses to set for the order. It will show their "default" address first, and then all other addresses. This list will not include any disabled addresses.

If the user has no enabled addresses (they are all disabled) then the user cannot check out on the cart page. They will see text where the check-out button would be, telling the user that they must have one enabled address in order to check out.

While an order is still "pending" (no items have been fulfilled, or the order is not "complete" or "canceled"), the user can alter the order to select a different shipping address.

The order show page should show the correct shipping address.

Statistics related to city/state should still work as before.

#### Mod 2 Learning Goals reflected:

- Database relationships
- ActiveRecord
- Software Testing

---

## More Merchant stats, Part 1 (counts as 1 extention point)

Build a Merchant leaderboard available on "/merchants" that all users can see:

- Top 10 Merchants who sold the most items this month
- Top 10 Merchants who sold the most items last month
- Top 10 Merchants who fulfilled non-cancelled orders this month
- Top 10 Merchants who fulfilled non-cancelled orders last month

When logged in as a user:

- Also see top 5 merchants who have fulfilled items the fastest to my state
- Also see top 5 merchants who have fulfilled items the fastest to my city

#### Mod 2 Learning Goals reflected:

- Advanced ActiveRecord
- Software Testing
- HTML/CSS layout and styling

---

## Coupon Codes (counts as 1 extension point)

Merchants can generate one-time-use coupon codes within the system.

Users can enter a coupon code as part of the check-out process. They'll need a field on the cart page where they can enter the code, and a button to "apply" the coupon. The page should show a flash message whether the coupon was successful, and if it was successful the cart should show a new "line item" for the coupon showing its discount, and how it affected the grant total.

The coupon could be good for one of many scenarios:
- a total percentage discount ("10% off entire order")
- a set dollar amount ("$10 off any order") but should not allow the price to below $0.00
- a dollar amount if the cart total exceeds a value ("$10 off orders of $20 or more")

Users should be able to apply the coupon and continue adding items to their cart. The coupon is considered "used" when the user checks-out successfully.

A coupon code can only apply to items in the order from that merchant, a coupon code cannot apply to other merchant's items.

You will need to build CRUD management pages for this as well.

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

You'll need to build CRUD pages to manage this.

Merchants must be able to include mutiple bulk discounts, but only one type. For example, a merchant cannot have bulk discounts that are both dollar-based ($10 off $30 or more) AND a percentage-off (15% off 20 items or more) at the same time.

#### Mod 2 Learning Goals reflected:

- Database relationships and migrations
- Advanced ActiveRecord
- Software Testing
- HTML/CSS layout and styling

---

## Downloadable Merchant User Lists (counts as 1 extension point)

Merchants can generate a list of email addresses for all existing users who are not disabled who have ordered items from this merchant in the past. The 4 columns must include: their name, email address, and how much money they've spent on your items, and how much they've spent from all merchants.

Merchants can generate a list of all new users who have never ordered from them before. Columns must include their name, email address, how much they've spent from other merchants, and how many orders they've made on the system.

These user lists should be downloadable CSV files, one user per line in the CSV.

#### Mod 2 Learning Goals reflected:

- Database relationships and migrations
- ActiveRecord
- Software Testing
- HTML/CSS layout and styling


## Merchant Statistics as charts (counts as 1 extension point)

Convert any statistics screen possible using charting JavaScript libraries like D3, C3 or Google Charts, or find a Ruby gem that can assist. Specifically:

- Merchant stats, pie chart about percentage of total inventory sold
- include a chart broken down by month for sales
- on `/merchants`, include a statistical pie chart showing the total sales on the whole site, and each merchant with fulfilled items on completed orders is shown in the pie chart

#### Mod 2 Learning Goals reflected:

- Database relationships and migrations
- ActiveRecord
- Software Testing
- HTML/CSS layout and styling

---

## Merchant To-Do List (counts as 1 extension point)

Merchants who visit their dashboard should see a list of "to-do" tasks such as:
- fixing items which are using a placeholder image
  - each of these items will appear on the dashboard page with a link going directly to that item's edit page where they can set a new image URL
- a count of how many orders are unfulfilled and the revenue impact ("You have 5 unfulfilled orders worth $752.86")


#### Mod 2 Learning Goals reflected:

- MVC and Rails development
- Database relationships and migrations
- ActiveRecord
- Software Testing
