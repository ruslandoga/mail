defmodule AWS.FinchClient do
  @moduledoc false
  @behaviour AWS.HTTPClient

  @impl true
  def request(method, url, body, headers, options) do
    req = Finch.build(method, url, headers, body, options)

    case Finch.request(req, M.finch(), options) do
      {:ok, %Finch.Response{status: status, headers: headers, body: body}} ->
        {:ok, %{status_code: status, headers: headers, body: body}}

      {:error, _reason} = error ->
        error
    end
  end
end
