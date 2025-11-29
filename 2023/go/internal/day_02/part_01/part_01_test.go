package part_01

import (
	"testing"
)

type data struct {
	gameId     int
	isPossible bool
	shownCubes []cubes
	line       string
}

var testInput = []data{
	{
		gameId:     1,
		isPossible: true,
		shownCubes: []cubes{
			{red: 4, blue: 3},
			{red: 1, blue: 6, green: 2},
			{green: 2},
		},
		line: "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",
	},
	{
		gameId:     2,
		isPossible: true,
		shownCubes: []cubes{
			{blue: 1, green: 2},
			{red: 1, blue: 4, green: 3},
			{blue: 1, green: 1},
		},
		line: "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue",
	},
	{
		gameId:     3,
		isPossible: false,
		shownCubes: []cubes{
			{red: 20, blue: 6, green: 8},
			{red: 4, blue: 5, green: 13},
			{red: 1, green: 5},
		},
		line: "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red",
	},
	{
		gameId:     4,
		isPossible: false,
		shownCubes: []cubes{
			{red: 3, blue: 6, green: 1},
			{red: 6, green: 3},
			{red: 14, blue: 15, green: 3},
		},
		line: "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red",
	},
	{
		gameId:     5,
		isPossible: true,
		shownCubes: []cubes{
			{red: 6, blue: 1, green: 3},
			{red: 1, blue: 2, green: 2},
		},
		line: "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green",
	},
}

func TestConvertLineToCubes(t *testing.T) {
	for _, data := range testInput {
		actualCubes := convertLineToCubes(data.line)

		if len(data.shownCubes) != len(actualCubes) {
			t.Errorf("Expected length of shownCubes to be %d, got %d", len(data.shownCubes), len(actualCubes))
		}

		for i, cubes := range data.shownCubes {
			if cubes != actualCubes[i] {
				t.Errorf("Expected shownCubes to be %v, got %v", cubes, actualCubes[i])
			}
		}
	}
}

func TestIsPossibleGame(t *testing.T) {
	maxCubes := cubes{red: 12, blue: 13, green: 14}

	for _, data := range testInput {
		actualIsPossible := isPossibleGame(data.shownCubes, maxCubes)

		if data.isPossible != actualIsPossible {
			t.Errorf("Expected isPossibleGame to be %t, got %t for game id %d", data.isPossible, actualIsPossible, data.gameId)
		}
	}
}

func TestGetGameId(t *testing.T) {
	for _, data := range testInput {
		actualGameId := getGameId(data.line)

		if data.gameId != actualGameId {
			t.Errorf("Expected gameId to be %d, got %d", data.gameId, actualGameId)
		}
	}
}
