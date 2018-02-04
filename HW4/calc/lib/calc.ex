defmodule Calc do
  @moduledoc """
  Documentation for Calc.
  Your program should consist of a Calc module (lib/calc.ex) with at least two functions:

  Calc.eval (String -> Number) # Should parse and evaulate an arithmetic expression.
  Calc.main # Should repeatedly print a prompt, read one line, eval it, and print the result.

  """

  #read input from console, call calculator, get result, then output to console

  def main do
    input = IO.gets(">")
    res = eval(input)
    IO.puts res
    main()

  end


  # calculate two numbers
  def cal(num1,num2,"+") do  num1 + num2 end
  def cal(num1,num2,"-") do  num1 - num2 end
  def cal(num1,num2,"*") do  num1 * num2 end
  def cal(num1,num2,"/") do  div(num1,num2) end


  def calculate(oper,num,s)  do
    if oper =="+" || oper == "-"do
      num = cal(0,num,oper)
    else
      elem1 = List.first(Tuple.to_list(s))
      num = cal(elem1,num,oper)
      s = Tuple.delete_at(s, 0)
    end
    Tuple.insert_at(s, 0, num)
  end

  # a calculator to calculate an expression
  def eval(exp) do

    exp
    |> String.replace("\n","")
    |> String.replace("(","( ")
    |> String.replace(")"," )")
    |> String.split(" ", trim: true)
    |> getCal(0,"+",{},{})
    |> Tuple.to_list
    |> Enum.sum
  end

  # calculate list of expression
  def getCal(lStr,res,oper,s1,s2) do
    elem1 = List.first(lStr)
    if elem1 == nil do
      calculate(oper, res, s1)
      else
      getOrder(lStr, res, oper, s1, s2)
    end
    end


   # decide calculate order
  def getOrder(lStr, res, oper, s1, s2)do
    elem1 = List.first(lStr)
    lStr = List.delete_at(lStr, 0)
    cond do
      elem1 == "(" ->
        s1 = Tuple.insert_at(s1, 0, elem1)
        s2 = Tuple.insert_at(s2, 0, oper)
        oper = "+"
      elem1 == ")" ->
        newS = calculate(oper, res, s1)
        id = newS
              |> Tuple.to_list
              |> Enum.find_index(fn(x) -> x == "(" end)
        res = newS
                  |> Tuple.to_list
                  |> Enum.slice(0, id)
                  |> Enum.sum
        {x, newS} = Enum.split(Tuple.to_list(newS), id+1)
        s1 = List.to_tuple(newS)
        oper = elem(s2, 0)
        s2 = Tuple.delete_at(s2, 0)
      elem1 in ["+","-","*","/"] ->
        s1 = calculate(oper, res, s1)
        res = 0
        oper = elem1
      true -> res = String.to_integer(elem1)
    end
    getCal(lStr, res, oper, s1, s2)

  end

end
