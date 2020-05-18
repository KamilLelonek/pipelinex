defmodule Pipelinex.Video do
  @enforce_keys ~w(title ratings)a
  defstruct @enforce_keys

  def new(params), do: struct!(__MODULE__, params)

  def encode(%__MODULE__{title: title}),
    do: %{"title" => title}
end
