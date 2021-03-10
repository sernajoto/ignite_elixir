defmodule ListFilterTest do
  use ExUnit.Case

  describe "call/1" do
    test "returns the quantity of odd numbers" do
      list = ["1", "3", "6", "43", "banana", "6", "abc", "7aa"]

      response = ListFilter.call(list)

      expected_response = 3

      assert response == expected_response
    end
  end
end
