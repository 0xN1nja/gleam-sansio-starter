# app

Starter template for creating sans-io pattern apps in Gleam

[![Package Version](https://img.shields.io/hexpm/v/app)](https://hex.pm/packages/app)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/app/)

## What is Sans-IO?

This template uses the sans-io approach, meaning your application code does not send HTTP requests itself. Instead, you write functions for creating HTTP requests and decoding HTTP responses, and you send the requests with a HTTP client of your choosing.

This HTTP client independence gives you:

- **Full control** - Choose any HTTP client (httpc, hackney, etc.)
- **Runtime flexibility** - Works on both Erlang and JavaScript runtimes
- **Easy testing** - Test request building and response parsing without network calls
- **Portability** - Swap HTTP clients without changing your core logic

This template includes example of GET request to JSONPlaceholder.

## Getting started

```bash
git clone https://github.com/0xN1nja/gleam-sansio-starter.git
cd gleam-sansio-starter
gleam test
```

## Authentication

This template contains minimal authentication example using Basic Auth, so you can get started immediately and see the pattern in action.

```gleam
import app

pub fn main() {
  let credentials =
    app.credentials("https://api.example.com")
    |> app.with_basic_auth("username", "password")

  // Use credentials to build the request
}
```

## Project Structure

When building your sans-io app, organize like this:

```
src/
├── app.gleam              # Core types and credentials
└── app/
    ├── internal/
    │   └── parser.gleam   # Response parsing utilities
    ├── internal.gleam     # Internal helpers
    └── get.gleam          # GET endpoint handler
```

Each endpoint module should export:

- A `request()` function - builds request data
- A `build()` function - adds credentials to request
- A `response()` function - parses response data
