# Asana

_A RESTful Web Service for Yogis._

Asana is a search engine for yogis, it helps yoga practitioners find poses to assist in the treatment of various ailments.

For example if someone has a cold or flu, they can search the API for list of poses to help alleviate symptoms, such as headstand (sirsasana).

## Getting Started and Contributing

### Setup

You will need a working copy of Elixir, 1.3 is recommended.

#### Install Dependencies

    $ mix deps.get
    $ mix deps.build
    $ mix run priv/repo/seed.exs

#### Running Tests

    $ mix test

#### Start the server

    $ iex -S mix
    $ curl http://locahost:4000

## Design Considerations

Asana is written in the very popular [Elixir language](http://elixir-lang.org/). Elixir was chosen because of it's highly scalable, fault tolerant properties, coupled with beautiful syntax and excellent support for building web applications.

To keep the code base small and easy to maintain, no heavy frameworks have been used. Only a few libraries:

 - [Plug](https://github.com/elixir-lang/plug) to route and handles requests.
 - [Ecto](https://github.com/elixir-ecto/ecto) for interfacing with SQL databases.
 - [Poison](https://github.com/devinus/poison) for handling JSON.

## API Documentation

The Asana HTTP service is a [RESTful](https://en.wikipedia.org/wiki/Representational_state_transfer), [JSON](https://en.wikipedia.org/wiki/JSON) API and will respond with appropriate content type headers:

    curl -H "Accept: application/json" -sv http://localhost:4000/ | jq
    *   Trying 127.0.0.1...
    * Connected to localhost (127.0.0.1) port 4000 (#0)
    > GET / HTTP/1.1
    > Host: localhost:4000
    > User-Agent: curl/7.43.0
    > Accept: application/json
    >
    < HTTP/1.1 200 OK
    < server: Cowboy
    < date: Wed, 30 Nov 2016 06:56:22 GMT
    < content-length: 159
    < cache-control: max-age=0, private, must-revalidate
    < content-type: application/json; charset=utf-8
    <
    { [159 bytes data]
    * Connection #0 to host localhost left intact
    {
      "links": {
        "self": "http://localhost:4000/",
        "search": "http://localhost:4000/search",
        "poses": "http://localhost:4000/poses"
      },
      "jsonapi": {
        "version": "1.0"
      },
      "data": []
    }

The API design follows the [JSON API specification](http://jsonapi.org/).

### GET /poses

Returns a list of all possible yoga poses.

### GET /poses/:id

Returns a specific possible yoga poses.

### GET /search?q={term}

Searches through all poses and finds the best pose based on an ailment, name or description.

For example, `$ curl http://localhost:4000/search?q=flu`

### Versioning

Choose a version by setting the `Accept-Version` header, for example `Accept-Version: 1`.

This is not required right now as there is only one version, although this could be subject to change so specify a version to future proof.

## Deployment Instructions

Deployment is performed using Ansible, Ansible is executed from local workstation, you can find installation instructions [here](http://docs.ansible.com/ansible/intro_installation.html)

The steps taken to install deploy Asana can be found inside `deploy.yml`.

Before running the deployment additional community built [roles](http://docs.ansible.com/ansible/playbooks_roles.html) are required, install those with:

    ansible-galaxy install -r roles.yml -p roles



