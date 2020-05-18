defmodule Pipelinex.VideoTest do
  use ExUnit.Case, async: true

  alias Pipelinex.{Video, Rating}

  @title "No Time to Die"
  @ratings [%Rating{author: "James Bond", comment: "Quite nice."}]
  @params %{title: @title, ratings: @ratings}

  describe "new/1" do
    test "should create a Video" do
      assert %Video{title: @title, ratings: @ratings} = Video.new(@params)
    end

    test "should not create a Video with missing params" do
      assert_raise(ArgumentError, fn -> Video.new(%{title: @title}) end)
      assert_raise(ArgumentError, fn -> Video.new(%{ratings: @ratings}) end)
    end
  end

  describe "encode/1" do
    test "should serialize a Video" do
      assert %{"title" => @title, "ratings" => @ratings} =
               @params
               |> Video.new()
               |> Video.encode()
    end

    test "should not serialize a Video" do
      assert_raise FunctionClauseError, fn -> Video.encode(@params) end
    end
  end
end
