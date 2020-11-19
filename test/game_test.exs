defmodule Exmon.GameTest do
    use ExUnit.Case
    alias ExMon.{Game, Player}

    describe "start/2" do
        test "starts the game state" do
            player = Player.build("Wagner", :chute, :soco, :cura)
            computer = Player.build("Robotnik", :chute, :soco, :cura)

            assert {:ok, _} = Game.start(player, computer)
        end
    end

    describe "info/0" do
        test "returns the current game status" do
            player = Player.build("Wagner", :chute, :soco, :cura)
            computer = Player.build("Robotnik", :chute, :soco, :cura)
            Game.start(player, computer)

            expected_response = 
            %{
                computer: %Player{life: 100, moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}, name: "Wagner"}, 
                player: %Player{life: 100, moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}, name: "Robotnik"},
                 status: :started, turn: :player
            }
            assert Game.info() == expected_response
        end
    end

    describe "update/1" do
        test "returns the updated game state" do
            player = Player.build("Wagner", :chute, :soco, :cura)
            computer = Player.build("Robotnik", :chute, :soco, :cura)
            Game.start(player, computer)

            expected_response =  
            %{
                computer: %Player{life: 100, moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}, name: "Wagner"}, 
                player: %Player{life: 100, moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}, name: "Robotnik"},
                 status: :started, turn: :player
            }

            assert Game.info() == expected_response

            new_state =  
            %{
                computer: %Player{life: 89, moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}, name: "Wagner"}, 
                player: %Player{life: 72, moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute}, name: "Robotnik"},
                 status: :started, turn: :player
            }

            Game.update(new_state)

            expected_response = %{new_state | turn: :computer, status: :continue}

            assert Game.info() == expected_response
        end
    end
end