# Readme
##  FastHome Delivery App 

## Overview

 FastHome Delivery is a web application built using Ruby on Rails (RoR) that simplifies the process of ordering food from various restaurants. This app provides a platform for users to browse through different restaurants, explore their menus, and place orders for delivery. Whether you're craving pizza, sushi, or something else entirely, FastHome Delivery has you covered.

## prerequisite
- ruby 3.2.0
- Rails 7.0.6
- Node 20.7.0 
- postgreSQL 16.0


## System dependencies
**libvip**
 ```bash
  sudo apt install libvips
   ```




## How to run the test suite

**To run test suite**
 ```bash
   bundle exec rspec spec
   ```

## Features

1. **Restaurant Listings**: Browse a variety of restaurants, each with its own unique menu and specialties.

2. **Dish Selection**: View detailed dish listings within each restaurant, including images, descriptions, prices, and customer ratings.

3. **User Authentication**: Users can create accounts, log in, and securely manage their profiles.

4. **Order Placement**: Easily place orders for delivery by adding dishes to the cart and specifying delivery details.

5. **Order History**: Keep track of your order history and reorder your favorite meals with a single click.

6. **Real-time Updates**: Receive real-time updates on the status of your order, from preparation to delivery.

7. **Restaurant Dashboard**: Restaurant owners can manage their menus, view and confirm incoming orders, and update order statuses.

8. **Delivery Dashboard**: It tells us about how delevery happens



## Technologies Used

FastHome Delivery is built using the following technologies:

- **Ruby on Rails (RoR)**: A web application framework for the Ruby programming language, known for its simplicity and convention over configuration.


- **Database**: PostgreSQL is used as the database management system.

- **Version Control**: Git is used for version control, and the codebase is hosted on a Git repository platform like GitHub.

## Getting Started

To get started with FastHome Delivery on your local machine, follow these steps:

1. Clone the repository from GitHub:

   ```bash
   git clone https://github.com/mehul-mob-dev/fast-home-backend
   cd fasthome-delivery
   ```

2. Install the required dependencies using Bundler:

   ```bash
   bundle install
   ```

3. Set up the database and run migrations:

   ```bash
   rails db:create
   rails db:migrate
   ```

4. Start the RoR development server:

   ```bash
   rails server
   ```

5. Open your web browser and navigate to `http://localhost:3000` to access the FastHome Delivery app.

6. Generate a development.key file and in that paste secret key.