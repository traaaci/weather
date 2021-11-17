defmodule Weather.ClientBehaviour do
  @callback http_get(url :: String.t()) :: {:ok, response :: list()} | {:error, reason :: term}
end
