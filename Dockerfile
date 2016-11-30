FROM elixir:1.2.6-slim

ENV MIX_ENV prod

ADD . asana/
WORKDIR /asana

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.compile
RUN mix compile

CMD ./start
