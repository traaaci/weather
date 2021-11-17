use Mix.Config

import_config "#{Mix.env()}.exs"

def get_tempatures(location) do
  http_client().get("https://www.metaweather.com/api/location/#{location}")
end

defp http_client do
  Application.get_env(:weather, :http_client)
end
