ExUnit.start()
Mox.defmock(Weather.ClientMock, for: Weather.ClientBehaviour)
Application.put_env(:weather, :http_client, HTTPoison.BaseMock)
