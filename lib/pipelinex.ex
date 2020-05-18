defmodule Pipelinex do
  defmacro __using__(_) do
    quote do
      require unquote(__MODULE__)

      import unquote(__MODULE__)
    end
  end

  defmacro left ~> right do
    quote do
      case unquote(left) do
        {:error, error} ->
          {:error, error}

        result ->
          result |> unquote(right)
      end
    end
  end
end
