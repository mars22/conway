defmodule ConwayTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  import Conway.CLI, only: [ parse_args: 1, process: 1]

  test ":help returned if options contains --help or -h" do
    assert parse_args(["--help", "test"])==:help
    assert parse_args(["-h","test"])==:help
  end

  test "should return give game size " do
    assert parse_args(["--size", "4"]) == 4

  end


  test "should return default game size" do
    assert parse_args([]) == 5

  end

  
end
