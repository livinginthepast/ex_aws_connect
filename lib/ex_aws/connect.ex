defmodule ExAws.Connect do
  @moduledoc """
  Operations on AWS Connect
  """

  @methods [
    list_phone_numbers: :get,
    list_queues: :get,
    list_users: :get,
    start_outbound_voice_contact: :put
  ]

  @doc "Provides information about the phone numbers in a specific Connect instance"
  @spec list_phone_numbers() :: ExAws.Operation.JSON.t()
  @spec list_phone_numbers(opts :: Keyword.t()) :: ExAws.Operation.JSON.t()
  def list_phone_numbers(opts \\ []) do
    request(:list_phone_numbers, opts)
  end

  @doc "Provides information about the queues in a specific Connect instance"
  @spec list_queues() :: ExAws.Operation.JSON.t()
  @spec list_queues(opts :: Keyword.t()) :: ExAws.Operation.JSON.t()
  def list_queues(opts \\ []) do
    request(:list_queues, opts)
  end

  @doc "Provides information about the users in a specific Connect instance"
  @spec list_users() :: ExAws.Operation.JSON.t()
  @spec list_users(opts :: Keyword.t()) :: ExAws.Operation.JSON.t()
  def list_users(opts \\ []) do
    request(:list_users, opts)
  end

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
      path: path(action, opts),
      headers: [
        {"content-type", "application/json"}
      ]
    }
    |> with_data(opts)
  end

  defp with_data(%ExAws.Operation.JSON{http_method: :get} = json, opts),
    do: %{json | params: parse_data(opts)}

  defp with_data(%ExAws.Operation.JSON{http_method: :put} = json, opts),
    do: %{json | data: parse_data(opts)}

  defp path(:list_phone_numbers, opts),
    do: "/phone-numbers-summary/" <> Keyword.fetch!(opts, :instance_id)

  defp path(:list_queues, opts), do: "/queues-summary/" <> Keyword.fetch!(opts, :instance_id)
  defp path(:list_users, opts), do: "/users-summary/" <> Keyword.fetch!(opts, :instance_id)
  defp path(:start_outbound_voice_contact, _opts), do: "/contact/outbound-voice"

  defp http_method(action), do: @methods |> Keyword.fetch!(action)

  def parse_data(opts) when is_list(opts), do: %{} |> parse_data(opts)
  def parse_data(data, []), do: data

  def parse_data(data, [{:attributes, attributes} | rest]) when is_map(attributes),
    do: data |> Map.put("Attributes", attributes) |> parse_data(rest)

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
