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
