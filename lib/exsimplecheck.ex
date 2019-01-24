defmodule Exsimplecheck do
  def gen_alphanumeric(bytes_count \\ 2) do
    user =
      bytes_count
      |> :crypto.strong_rand_bytes()
      |> Base.url_encode64(padding: false)

    user
  end

  def get(user) do
    case(HTTPoison.get("https://api.mojang.com/users/profiles/minecraft/#{user}")) do
      {:ok, %HTTPoison.Response{status_code: 200}} -> IO.puts("#{user} taken")
      {:ok, %HTTPoison.Response{status_code: 204}} -> IO.puts("#{user} open")
      _ -> :error
    end
  end

  def check() do
    :timer.sleep(1000)
    Exsimplecheck.gen_alphanumeric() |> Exsimplecheck.get()
    check()
  end
end
