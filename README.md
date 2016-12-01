# Asana

_A RESTful Web Service for Yogis._

[![Build Status](https://travis-ci.org/pmyjavec/asana.svg?branch=master)](https://travis-ci.org/pmyjavec/asana)

Asana is a search engine for yogis, it helps yoga practitioners find poses to assist in the treatment of various ailments.

For example if someone has a cold or flu, they can search the API for list of poses to help alleviate symptoms, such as headstand (sirsasana).

## Design Considerations

### Web-service

Asana is written in the relatively new, but ever more popular [Elixir language](http://elixir-lang.org/). Elixir because of it's highly scalable, fault tolerant nature, coupled with beautiful syntax and excellent libraries for building modern web applications with little time investment. It's an interesting language.

To keep the code base small and easy to maintain, no heavy frameworks have been used. Only a few libraries:

 - [Plug](https://github.com/elixir-lang/plug) to route and handles requests.
 - [Ecto](https://github.com/elixir-ecto/ecto) for interfacing with SQL databases.
 - [Poison](https://github.com/devinus/poison) for handling JSON.

### Searching

Searching, I was able to leverage the [full-text search capabilities](https://www.postgresql.org/docs/current/static/textsearch.html) available in PostgreSQL, which were actually quite impressive.

### Deployment

I've primarily leaned on Docker for deployment of the application instances, I've had very good experience with Docker in the past and felt like it was a good fit for deployment of such as light-weight, stateless web-service.

Official Elixir images are available and so very little time investment was needed order to get a working image deployed.

Docker images are built from Travis CI builds and pushed out to [Docker Hub](https://hub.docker.com/r/pmyjavec/asana/), then deployed to a target host of your choice using Ansible. See the deployment section for more information.

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

Returns an individual yoga poses.

### GET /search?q={term}

Searches through all poses and finds the best pose based on an ailment, name or description.

For example, `$ curl http://localhost:4000/search?q=flu`

### Versioning

Currently there is no version headers needed as this is a first version API.

Feel free to send the `Accept-Version` header, for example `Accept-Version: 1`, if you don't want to automatically get bumped to new versions in the future.

## Deployment

The deployment is performed primarily by using [Ansible](http://docs.ansible.com/ansible/index.html), Ansible is executed from local workstation and runs the deployment over SSH, you can find installation instructions for Ansible [here](http://docs.ansible.com/ansible/intro_installation.html)

### Pre-requisites

    * To be able to login to the target server without a password.
    * The user used to run the deployment must either be root, or able to run sudo commands as root.
    * The latest Ansible installed.
    * The target host needs the `python-minimal` package installed. _The deploy script will install python for you._
    * The target host is _64 bit_

### Running the deployment

The script is fairly well commented, so checkout the script contents for details on it's workings.

     git clone https://github.com/pmyjavec/asana
     cd asana
    ./deploy

## Contributing

### Setup

You will need a working copy of Elixir, 1.3 is recommended.

#### Install Deps

    $ mix deps.get
    $ mix deps.build
    $ mix run priv/repo/seed.exs

#### Running Tests

    $ mix test

#### Start the server

    $ iex -S mix
    $ curl http://locahost:4000
