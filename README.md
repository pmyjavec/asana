# Asana

_A RESTful Web Service for Yogis._

Asana helps Yoga practitioners find poses to assist in the treatment of various ailments.

For example if someone has a cold or flu they can query the API for list of poses to help alleviate symptoms, such as Sirsasana (headstand).

## Getting Started and Contributing

### Setup
    | $ mix deps.get
    | $ mix deps.build

### Start the server
    | $ iex -S mix

### Running Tests

    | $ mix test

## Design Considerations

Asana is written in the very popular [Elixir language](http://elixir-lang.org/). Elixir was chosen because of it's highly scalable, fault tolerant properties, coupled with beautiful syntax and excellent support for building web applications.

To keep the code base small and simple and the service quick, no heavy frameworks have been used. Only a few libraries:

 - [Plug](https://github.com/elixir-lang/plug) to route and handles requests.
 - [Ecto](https://github.com/elixir-ecto/ecto) for interfacing with SQL databases.
 - [Poison](https://github.com/devinus/poison) for handling JSON.

## Deployment Instructions

TBA

## API Documentation

### GET /poses

Returns a list of all possible Yoga poses.

### GET /poses/:id

Returns a list of all possible Yoga poses.

### GET /poses/search?query={terms}

Searches through all poses and finds the best pose based on an ailment.

### Versioning

Choose a version by setting the `Accept-Version` header, for example `Accept-Version: 1`.

This is not required right now as there is only one version, although this could be subject to change so specify a version to future proof.
