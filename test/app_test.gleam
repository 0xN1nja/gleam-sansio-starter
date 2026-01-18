import app
import app/get
import gleam/httpc
import gleam/io

pub fn main() {
  // Set up credentials
  let credentials =
    app.credentials("https://jsonplaceholder.typicode.com/posts")

  // Build request
  let request =
    get.request(1)
    // Get post with ID 1
    |> get.build(credentials)

  // Execute request by the HTTP client of your choice
  let assert Ok(response) = httpc.send(request)

  // Parse response
  let assert Ok(data) = get.response(response)

  io.println(data.body)
}
