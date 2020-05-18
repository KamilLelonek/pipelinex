defmodule PipelinexTest do
  use ExUnit.Case, async: true
  use Pipelinex

  require Pipelinex

  @text "Some random STRING."

  describe "~>" do
    test "should behave the same as the regular pipe operator" do
      assert @text
             |> String.downcase()
             |> String.split() ==
               @text
               ~> String.downcase()
               ~> String.split()
    end

    test "should handle error results" do
      assert {:error, "invalid API key"} == "API KEY" ~> download() ~> parse()
    end

    test "should pass successful flow" do
      assert %{downloaded_at: _timestamp, message: "valid result"} = 123 ~> download() ~> parse()
    end

    defp download(123), do: {:ok, "valid result"}
    defp download(_), do: {:error, "invalid API key"}
    defp parse({:ok, message}), do: %{message: message, downloaded_at: Time.utc_now()}
  end
end
