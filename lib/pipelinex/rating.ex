defmodule Pipelinex.Rating do
  @enforce_keys ~w(author comment)a
  defstruct @enforce_keys

  def new(params), do: struct!(__MODULE__, params)

  def encode(%__MODULE__{author: author, comment: comment}) do
    %{
      "author" => author,
      "comment" => comment
    }
  end
end
