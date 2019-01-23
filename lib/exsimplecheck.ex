defmodule Exsimplecheck do
  def gen_alphanumeric(bytes_count \\ 2) do
    user =
      bytes_count
      |> :crypto.strong_rand_bytes()
      |> Base.url_encode64(padding: false)

    IO.puts("Checking #{user}..")
    user
  end

  def get(user) do
    case(HTTPoison.get("https://api.mojang.com/users/profiles/minecraft/#{user}")) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> body
      {:ok, %HTTPoison.Response{status_code: 204}} -> body = nil
      _ -> :error
    end
  end

  def process_body(nil), do: IO.puts("Username available!!!")
  def process_body(body), do: IO.puts("Username taken...")

  def check() do
    :timer.sleep(1000)
    Exsimplecheck.gen_alphanumeric() |> Exsimplecheck.get() |> Exsimplecheck.process_body()
    check()
  end
end
