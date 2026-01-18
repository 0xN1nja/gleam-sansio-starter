import app.{type Credentials}
import gleam/http
import gleam/http/request.{type Request, Request}
import gleam/option.{None, Some}
import gleam/result

pub fn request(
  credentials: Credentials,
  method: http.Method,
  path: String,
  headers: List(#(String, String)),
  body: String,
) -> Request(String) {
  let request =
    Request(
      method:,
      headers:,
      body:,
      scheme: result.unwrap(
        http.scheme_from_string(option.unwrap(credentials.scheme, "https")),
        http.Https,
      ),
      host: option.unwrap(credentials.host, ""),
      port: credentials.port,
      path:,
      query: credentials.query,
    )

  case credentials.auth_header {
    Some(header) ->
      request
      |> request.prepend_header("Authorization", header)

    None -> request
  }
}
