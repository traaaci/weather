defmodule WeatherTest do
  use ExUnit.Case, async: true

  test "Get tempatures/0" do
    Mox.stub_with(Weather.ClientMock, Weather.DefaultMockHttpClientResponse)

    assert Weather.get_temps() == [
             "Average Tempature of salt_lake_city 10.49",
             "Average Tempature of los_angeles 22.79",
             "Average Tempature of boise 8.82"
           ]
  end
end
