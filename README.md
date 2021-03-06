# Up In The Air
Up In The Air is a service which helps you find mutually convenient (or inconvenient) places for you and your friends to visit on holiday.

# Useful information

## Putting your view inside a consistent container

To create a new view inside the `container` partial, create a file (say `app/views/pages/help.html.erb`) and put the following inside:

```ruby
# app/views/pages/help.html.erb
<%= render "shared/container" do %>
  {{INSERT CONTENT HERE}}
<%= end %>
```

## Pundit

This project uses Pundit to authorise user actions. The lecture slides on this can be found [here](https://kitt.lewagon.com/camps/476/lectures/05-Rails%2F07-Airbnb-Facebook-connect). If in doubt, ask/blame [@gtm19](https://github.com/gtm19).

---

Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.

## SEED
The seed file will delete all data and add:

**Cities**
There are 874 european airports.
The city name is currently set to the airport name. This can be adjusted in future (TODO).

**Users**
There are 5 users all with European cities as their start city
Pat Sharpe is the lead user
A trip will be created for Pat Sharpe
Trip participants are also created

**Trips Estimates**
Only exist from the 5 cities of the users to *all* other european cities
They are validate from 1 May 2021 to 1 May 2022
Distances and prices have been set


## ENRICH CITIES
Need to do the following (these are instructions of OSX, check Windows) to run **sidekiq**

```
brew update
brew install redis
brew services start redis
bundle install
bundle binstub sidekiq
sidekiq
```

In a new terminal run:

```
Rails c
AddPhotosJob.perform_later
```

This will take 10 mins to run. There may be some timeouts warnings, but it seems to resolve itself eventually.
