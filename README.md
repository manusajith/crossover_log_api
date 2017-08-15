# LogApi

LogApi is a REST based application which allows users to register an application name and record log events to it.

The application is written in Elixir, uses Phoenix framework and is architected around DDD/CQRS/EventSourcing pattern

Other noteable libraries:

* Guardian for authentication
* Hammer for rate limitting

## Getting started

LogApi is an Elixir 1.5 application using Phoenix 1.3 and PostgreSQL for persistence.

### Prerequisites

You must install the following dependencies before starting:

- [Git](https://git-scm.com/).
- [Elixir](https://elixir-lang.org/install.html) (v1.5 or later).
- [PostgreSQL](https://www.postgresql.org/) database (v9.5 or later).

### Configuring LogApi

1. Install mix dependencies:

    ```console
    $ cd logapi
    $ mix deps.get
    ```

2. Update your username and password for PostgreSQL in `config/dev.exs` file

3. Create the event store database:

    ```console
    $ mix event_store.create
    ```

4. Create the read model store database:

    ```console
    $ mix do ecto.create, ecto.migrate
    ```

5. Run the Phoenix server:

    ```console
    $ mix phx.server
    ```

  This will start the web server on localhost, port 8080: [http://0.0.0.0:8080](http://0.0.0.0:8080)

This application *only* includes the API back-end, serving JSON requests.


#### Interaction with API

For registering a new application:

```
curl -X POST \
  http://localhost:4000/api/register \
  -H 'content-type: application/json' \
  -d '{
		"display_name": "crossover",
		"password": "changeme"
}'
```

For recording a log to an application

Note: Replace the Auth token, and also the application_uuid obtained from the above step

```
curl -X POST \
  http://localhost:4000/api/log \
  -H 'authorization: Application eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJBcHBsaWNhdGlvbjo4ZTZmY2JhNS00ZWM4LTQ1MzUtODA3Zi1hNjZkYWQzNTE4MjAiLCJleHAiOjE1MDU2NzQ0MDAsImlhdCI6MTUwMzA4MjQwMCwiaXNzIjoiTG9nQXBpIiwianRpIjoiZDBjN2YzMzYtMDYwNi00YTU0LWJmN2EtYzgyN2QzMjE0NmQ5IiwicGVtIjp7fSwic3ViIjoiQXBwbGljYXRpb246OGU2ZmNiYTUtNGVjOC00NTM1LTgwN2YtYTY2ZGFkMzUxODIwIiwidHlwIjoidG9rZW4ifQ.ORTFE2tyt9AA6yn4AQvSaoIiemNMxJLHCoxoeAqurZ-4oI0YjwjACbshJDA2j-WAfnKlVB6NgZUv5cFkVUW6EQ' \
  -H 'content-type: application/json' \
  -d '{
	"logger": "hello",
	"level": "error",
	"message": "500 error",
	"application_uuid": "a4638699-16a4-4d93-b770-ea2702545f3d"
}'
```

#### Running tests

1. Update the postgres user credentials in `config/test.exs`

```
mix test
```

#### Notes and Assumptions

1. App is not configured for production deployment using a build/release tool like distillery.
2. Request and Response was a bit altered for the `/logging` endpoint. Instead if just returning success as true/false, it will return the logged response
3. Newer versions of Elixir, Phoenix and OTP are used.
4. Docker and DockerCompose files attached are not fully functional - Ran out of time :(
