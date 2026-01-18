import app
import gleam/dynamic/decode
import gleam/json

pub type JsonPlaceholder {
  JsonPlaceholder(userid: Int, id: Int, title: String, body: String)
}

pub fn parse_json(json_string: String) -> Result(JsonPlaceholder, app.AppError) {
  let decoder = {
    use userid <- decode.field("userId", decode.int)
    use id <- decode.field("id", decode.int)
    use title <- decode.field("title", decode.string)
    use body <- decode.field("body", decode.string)
    decode.success(JsonPlaceholder(userid:, id:, title:, body:))
  }

  case json.parse(from: json_string, using: decoder) {
    Ok(parsed) -> Ok(parsed)
    Error(_) -> Error(app.JsonParseError("Failed to parse JSON"))
  }
}
