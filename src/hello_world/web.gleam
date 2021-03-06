import gleam/bit_builder
import gleam/bit_string
// Unqualified import. Allows using Get directly, instead of typing http.Get
import gleam/http.{Get}
import gleam/http/elli
import gleam/http/middleware
import hello_world/logger

fn hello_world() {
  let body =
    "Hello, World!"
    |> bit_string.from_string

  // This function returns the result of this expression, as it's the last expression the block.
  http.response(200)
  |> http.set_resp_body(body)
  |> http.prepend_resp_header("content-type", "text/plain")
}

fn not_found() {
  let body =
    "There's nothing here."
    |> bit_string.from_string

  http.response(404)
  |> http.set_resp_body(body)
  |> http.prepend_resp_header("content-type", "text/plain")
}

pub fn app(req) {
  let path = http.path_segments(req)

  case req.method, path {
    // Hello world for GET requests with no path or any path
    Get, [] | Get, _ -> hello_world()
    // 404 for others
    _, _ -> not_found()
  }
}

pub fn start() {
  let server =
    app
    |> middleware.map_resp_body(bit_builder.from_bit_string)
    |> logger.middleware

  elli.start(server, on_port: 3000)
}
