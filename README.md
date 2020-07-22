# MelpIntellimetrica

## Heroku Deployment
  * Requires Elixir buildpack - `heroku buildpacks:set https://github.com/HashNuke/heroku-buildpack-elixir`
  * Set the pool size so Phoenix doesn't overload Heroku -`heroku config:set POOL_SIZE=18`
  * Generate secret with `mix phx.gen.secret` and run - `heroku config:set SECRET_KEY_BASE="$$$KEY$$$"`
  * After pushing to Heroku run the following - `heroku run "POOL_SIZE=2 mix ecto.migrate"`

The included Procfile automatically tells Heroku to run `mix phx.server`


## Endpoints
  * /restaurants/statistics - takes latitude, longitude and radius in GET request. Example: `https://intellimetrica-test-pablo.herokuapp.com/restaurants/statistics?latitude=19.4400570537131&longitude=-99.1270470974249&radius=10`
  Returns a JSON containing the count, average rating and std. deviation of restaurants in a given radius.

  * /restaurants/byCity - takes city in a GET request. Example: `https://intellimetrica-test-pablo.herokuapp.com/restaurants/byCity?city=Querétaro`
  Returns a JSON containing all restaurants in a given city.

  * /restaurants/byState - takes state in a GET request. Example: `https://intellimetrica-test-pablo.herokuapp.com/restaurants/byCity?state=Jalisco`
  Returns a JSON containing all restaurants in a given state.

  * /restaurants/byRating - takes rating in a GET request. Example: `https://intellimetrica-test-pablo.herokuapp.com/restaurants/byCity?rating=3`
  Returns a JSON containing all restaurants with a given rating.

  * /restaurants/rating - takes no parameters. Example: `https://intellimetrica-test-pablo.herokuapp.com/restaurants/ratingStatistics`
  Returns a JSON with the percentage of restaurants with all ratings (0 - 5).

