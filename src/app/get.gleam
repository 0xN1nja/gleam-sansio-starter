import app.{type Credentials}
import app/internal
import app/internal/parser
import gleam/http
import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import gleam/int

pub type RequestBuilder {
  RequestBuilder(id: Int)
}

pub fn request(id: Int) -> RequestBuilder {
  RequestBuilder(id:)
}

pub fn build(
  builder: RequestBuilder,
  credentials: Credentials,
) -> Request(String) {
  let headers = []
  let body = ""

  internal.request(
    credentials,
    http.Get,
    credentials.path <> "/" <> int.to_string(builder.id),
    headers,
    body,
  )
}

pub fn response(
  response: Response(String),
) -> Result(parser.JsonPlaceholder, app.AppError) {
  case response.status {
    200 -> parser.parse_json(response.body)

    404 ->
      Error(
        app.UnexpectedResponseError(response.set_body(
          response,
          "Resource not found",
        )),
      )

    401 | 403 -> Error(app.AuthenticationError("Authentication failed"))

    _ ->
      Error(app.UnexpectedError(
        "Unexpected HTTP status: " <> int.to_string(response.status),
      ))
  }
}
