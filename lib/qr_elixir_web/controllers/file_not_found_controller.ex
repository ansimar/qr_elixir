defmodule QrElixirWeb.FileNotFoundController do
  use QrElixirWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(404)
    |> text("File Not Found")
  end
end
