defmodule ExMon do
  alias ExMon.{Player, Game}
  alias ExMon.Game.{Actions, Status}

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

    Status.print_round_message()
  end

  def make_move(move) do
    move
    |> Actions.fetch_move()
    |> do_move()
  end

  defp do_move({:error, move}), do: Status.print_wrong_move_message(move)

  defp do_move({:ok, move}) do
    case move do
      :move_heal -> "realiza_cura"
      move -> Actions.attack(move)
    end
  end
end

# player = ExMon.create_player("Wagner", :chute, :soco, :cura)
# player = ExMon.create_player("Wagner", :chute, :soco, :cura)
# ExMon.start_game(player)
# ExMon.Game.player

