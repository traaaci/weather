defmodule Client do
  @behaviour Weather.ClientBehaviour
  def http_get(url) do
    HTTPoison.get(url)
  end
end
