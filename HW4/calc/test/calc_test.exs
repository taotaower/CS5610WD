defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "exp1" do
    assert Calc.eval("1 + 2") == 3
  end

  test "exp2" do
    assert Calc.eval("(1 + 2) / 2 + ((1 + 2) * 5) * 6") == 91
  end

  test "exp3" do
    assert Calc.eval("1 + 2 / 3 * 6 + ((1 + 2) / 3) * 4") == 5
  end
end
