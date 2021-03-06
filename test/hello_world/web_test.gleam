import hello_world/web
import gleam/http.{Get, Post}
import gleam/should

pub fn not_found_test() {
  let resp =
    http.default_req()
    |> http.set_method(Post)
    |> http.set_path("/")
    |> http.set_req_body(<<>>)
    |> web.app()

  resp.status
  |> should.equal(404)

  resp.body
  |> should.equal(<<"There's nothing here.":utf8>>)
}

pub fn hello_world_1_test() {
  let resp =
    http.default_req()
    |> http.set_method(Get)
    |> http.set_path("/")
    |> http.set_req_body(<<>>)
    |> web.app()

  resp.status
  |> should.equal(200)

  resp.body
  |> should.equal(<<"Hello, World!":utf8>>)
}

pub fn hello_world_2_test() {
  let resp =
    http.default_req()
    |> http.set_method(Get)
    |> http.set_path("/hello/world/path")
    |> http.set_req_body(<<>>)
    |> web.app()

  resp.status
  |> should.equal(200)

  resp.body
  |> should.equal(<<"Hello, World!":utf8>>)
}
