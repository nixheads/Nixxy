defmodule Metis.IRC.Bot.Config do
  @moduledoc "Configuration module for bot."

  alias Metis.IRC.Bot.Config

  @doc """
  Configuration struct for bot.
  """
  defstruct bot_id: nil,
    enabled: nil,
    params: %{},
    client: nil

  @doc """
  Inserts value into configuration if its key exists there.
  Returns: provided Configuration.
  """
  @spec insert_if({any(), any()}, %Config{}) :: %Config{}
  def insert_if({k, v}, config) do
    case Map.has_key?(config, k) do
      true ->
        Map.put(config, k, v)
      false ->
        config
    end
  end

  @doc """
  Constructs a Configuration from parameters.
  """
  @spec from_params(map()) :: %Config{}
  def from_params(params) when is_map(params) do
    Enum.reduce(params, %Config{}, fn {k, v}, acc ->
      case Map.has_key?(acc, k) do
        true -> Map.put(acc, k, v)
        false -> acc
      end
    end)
  end
end
