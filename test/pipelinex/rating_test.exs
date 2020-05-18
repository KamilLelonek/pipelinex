defmodule Pipelinex.RatingTest do
  use ExUnit.Case, async: true

  alias Pipelinex.Rating

  @author "Johntra Volta"
  @comment "Very good!"
  @params %{author: @author, comment: @comment}

  describe "new/1" do
    test "should create a Rating" do
      assert %Rating{author: @author, comment: @comment} = Rating.new(@params)
    end

    test "should not create a Rating with missing params" do
      assert_raise(ArgumentError, fn -> Rating.new(%{author: @author}) end)
      assert_raise(ArgumentError, fn -> Rating.new(%{comment: @comment}) end)
    end
  end

  describe "encode/1" do
    test "should serialize a Rating" do
      assert %{"author" => @author, "comment" => @comment} =
               @params
               |> Rating.new()
               |> Rating.encode()
    end

    test "should not serialize a Rating" do
      assert_raise FunctionClauseError, fn -> Rating.encode(@params) end
    end
  end
end
