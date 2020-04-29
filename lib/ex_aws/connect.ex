defmodule ExAws.Connect do
  @moduledoc """
  Operations on AWS Connect
  """

  @paths [
    start_outbound_voice_contact: "/contact/outbound-voice"
  ]

  @methods [
    start_outbound_voice_contact: :put
  ]

  @doc "Start outbound voice contact"
  @spec start_outbound_voice_contact() :: ExAws.Operation.JSON.t()
  @spec start_outbound_voice_contact(opts :: Keyword.t()) :: ExAws.Operation.JSON.t()
  def start_outbound_voice_contact(opts \\ []) do
    request(:start_outbound_voice_contact, opts)
  end

  defp request(action, opts) do
    %ExAws.Operation.JSON{
      service: :connect,
      http_method: http_method(action),
      path: path(action),
      data: parse_data(opts),
      headers: [
        {"content-type", "application/json"}
      ]
    }
  end

  defp path(action), do: @paths |> Keyword.fetch!(action)
  defp http_method(action), do: @methods |> Keyword.fetch!(action)

  def parse_data(opts) when is_list(opts), do: %{} |> parse_data(opts)
  def parse_data(data, []), do: data

  def parse_data(data, [{:client_token, token} | rest]),
    do: data |> Map.put("ClientToken", token) |> parse_data(rest)

  def parse_data(data, [{:contact_flow_id, token} | rest]),
    do: data |> Map.put("ContactFlowId", token) |> parse_data(rest)

  def parse_data(data, [{:instance_id, token} | rest]),
    do: data |> Map.put("InstanceId", token) |> parse_data(rest)

  def parse_data(data, [{:destination_phone_number, token} | rest]),
    do: data |> Map.put("DestinationPhoneNumber", token) |> parse_data(rest)

  def parse_data(data, [{:queue_id, token} | rest]),
    do: data |> Map.put("QueueId", token) |> parse_data(rest)

  def parse_data(data, [{:source_phone_number, token} | rest]),
    do: data |> Map.put("SourcePhoneNumber", token) |> parse_data(rest)

  def parse_data(_data, [{key, _value} | _rest]),
    do: raise(ArgumentError, "unknown option #{key}")
end
