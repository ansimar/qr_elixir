defmodule QrElixirWeb.GeneratorController do
  use QrElixirWeb, :controller

  def home(conn, _params) do
    render(conn, :home, url: nil, qr: nil)
  end

  def result(conn, params) do
    IO.inspect(">>>>>>>>>>> Generating a QR CODE <<<<<<<<<<<")
    IO.inspect(params)

    %{"url" => url} = params
    render(conn, :home, url: url, qr: generate_qr(url))
  end

  defp generate_qr(url) do
    qr_code =
      url
      |> QRCodeEx.encode()
      |> QRCodeEx.png()

    rnd_name = for _ <- 1..10, into: "", do: <<Enum.random(~c"0123456789abcdef")>>
    file_name = "/uploads/generated_qr/#{rnd_name}.png"
    File.write!("priv/static#{file_name}", qr_code)

    "/generated/#{rnd_name}.png"
  end
end
