defmodule Keys do
  @moduledoc """
  API keys are stored seperatly to be encrypted by git-crypt
  """
  defp read_file(file) do
    File.read!(file)
  end
    ## Constant functions
  def apikeystop() do
    read_file("lib/keys/stop")
  end

  def apikeysite() do
    read_file("lib/keys/site")
  end
end
