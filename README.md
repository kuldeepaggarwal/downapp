# Flights

### Prerequisite

- Ruby v2.5.3
- Bundler gem v2.0.1

### Steps to setup

1. Clone the project
2. cd to the project
3. Run `bundle install`


### Steps to Run the server

1. `bundle exec rails s`, Now the server will be accessible at http://localhost:3000.


API:

1.

Endpoint: `/api/v1/flights`
Parameters:

1. max_duration: It is an integer which represents hours.
2. min_duration: It is an integer which represents hours.
3. preferences: It is an array consists of carriers.
4. max_distance: It is an integer which represents miles.

Response: It returns a list of flights ordered by score.

Example: http://localhost:3000/api/v1/flights?max_duration=1.5&min_duration=1&preferences[]=FR&preferences[]=DL&max_distance=1200
