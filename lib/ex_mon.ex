defmodule ExMon do
  alias ExMon.{Player, Game}

  @computer_name "Robotnik"

  @moduledoc """
  Documentação módulo `ExMon`.
  """

  @doc """
  ## Examples
      iex> ExMon.create_player()


  """
  def create_player(name, move_rnd, move_avg, move_heal) do
    Player.build(name, move_rnd, move_avg, move_heal)
  end

  def start_game(player) do
    @computer_name
    |> create_player(:punch, :kick, :heal)
    |> Game.start(player)
  end
end
