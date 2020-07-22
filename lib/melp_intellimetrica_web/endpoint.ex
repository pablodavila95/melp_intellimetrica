defmodule MelpIntellimetricaWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :melp_intellimetrica

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_melp_intellimetrica_key",
    signing_salt: "aOS7IVUa"
  ]

  plug Plug.RequestId

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug MelpIntellimetricaWeb.Router
end
