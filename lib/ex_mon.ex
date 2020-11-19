defmodule ExMon do
  alias ExMon.{Player, Game}
  alias ExMon.Game.{Actions, Status}

  @computer_name "Robotnik"
  @computer_moves [:move_avg, :move_rnd, :move_heal]

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

    Status.print_round_message(Game.info())
  end

  def make_move(move) do
    Game.info()
    |> Map.get(:status)
    |> handle_status(move)
  end

  defp handle_status(:game_over, _), do: Status.print_round_message(Game.info())
  defp handle_status(_, move) do
    move
    |> Actions.fetch_move()
    |> do_move()

    computer_move(Game.info())

  end


  defp do_move({:error, move}), do: Status.print_wrong_move_message(move)

  defp do_move({:ok, move}) do
    case move do
      :move_heal -> Actions.heal()
      move -> Actions.attack(move)
    end
    Status.print_round_message(Game.info())
  end

  defp computer_move(%{turn: :computer, status: :continue}) do
    {:ok, Enum.random(@computer_moves)}
    |> do_move()
  end

  defp computer_move(_), do: :ok
end

# player = ExMon.create_player("Wagner", :chute, :soco, :cura)
# player = ExMon.create_player("Wagner", :chute, :soco, :cura)
# ExMon.start_game(player)
# ExMon.Game.player
