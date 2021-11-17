defmodule Weather do
  alias Client
  @http_client Application.get_env(:weather, :http_client, Client)
  def get_temps() do
    [
      salt_lake_city: "https://www.metaweather.com/api/location/2487610/",
      los_angeles: "https://www.metaweather.com/api/location/2442047/",
      boise: "https://www.metaweather.com/api/location/2366355/"
    ]
    |> Enum.map(fn {location, url} ->
      result =
        url
        |> @http_client.http_get()
        |> parse_response

      case result do
        {:ok, temp} ->
          "Average Tempature of #{location} #{temp}"

        :error ->
          "#{location} not found"
      end
    end)
  end

  defp parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    body
    |> JSON.decode!()
    |> compute_temperature
  end

  defp parse_response(_) do
    :error
  end

  defp compute_temperature(json) do
    temps =
      json["consolidated_weather"]
      |> Enum.map(fn temp -> Map.get(temp, "max_temp") |> Decimal.from_float() end)

    length_temp = length(temps)

    sum = Enum.reduce(temps, fn x, y -> Decimal.add(x, y) end)
    average = Decimal.round(Decimal.div(sum, length_temp), 2)

    {:ok, average}
  end
end
