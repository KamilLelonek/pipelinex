defmodule Pipelinex.Application do
  @moduledoc false

  use Application

  def start(_type, _args), do: Supervisor.start_link(children(), opts())

  defp children, do: []

  defp opts do
    [
      strategy: :one_for_one,
      name: Pipelinex.Supervisor
    ]
  end
end
