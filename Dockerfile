FROM elixir:1.10.4-alpine

RUN apk add --update make alpine-sdk nodejs npm postgresql

WORKDIR /app

COPY . ./

RUN mix local.hex --force

RUN mix local.rebar --force

# RUN mix clean

# RUN mix deps.get

# RUN mix deps.compile

# RUN npm install --prefix=assets

# RUN mix ecto.create

# RUN mix ecto.migrate

# CMD ["mix", "phx.server"]

# CMD ["./migrate_and_run.sh"]

# CMD ["/bin/ash"]