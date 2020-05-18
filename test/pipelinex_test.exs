defmodule PipelinexTest do
  use ExUnit.Case, async: true
  use Pipelinex

  require Pipelinex

  alias Pipelinex.{Video, Rating}

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

  describe "serialize" do
    @rating1 %Rating{author: "James Bond", comment: "Quite nice."}
    @rating2 %Rating{author: "Sherlock Holmes", comment: "Pretty good."}
    @ratings [@rating1, @rating2]
    @video %Video{title: "Iron Man 3", ratings: @ratings}

    test "should encode flat arguments" do
      assert %{"title" => "Iron Man 3"} = Video.encode(@video)
    end

    test "should encode nested arguments" do
      result =
        @video
        |> Video.encode()
        |> case do
          %{"ratings" => ratings} = video ->
            %{video | "ratings" => Enum.map(ratings, &Rating.encode/1)}
        end
        |> Map.values()
        |> List.flatten()

      assert [
               %{"author" => "James Bond", "comment" => "Quite nice."},
               %{"author" => "Sherlock Holmes", "comment" => "Pretty good."},
               "Iron Man 3"
             ] = result
    end
  end
end
