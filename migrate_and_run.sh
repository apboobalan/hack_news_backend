#!/usr/bin/env bash

cd /app
mix ecto.create
mix ecto.migrate
mix phx.server