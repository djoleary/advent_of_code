package part_02

import (
	"testing"
)

type data struct {
	shownCubes []cubes
	maxCubes   cubes
	line       string
}

var testInput = []data{
	{
		shownCubes: []cubes{
			{red: 4, blue: 3},
			{red: 1, blue: 6, green: 2},
			{green: 2},
		},
		maxCubes: cubes{red: 4, blue: 6, green: 2},
		line:     "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",
	},
	{
		shownCubes: []cubes{
			{blue: 1, green: 2},
			{red: 1, blue: 4, green: 3},
			{blue: 1, green: 1},
		},
		maxCubes: cubes{red: 1, blue: 4, green: 3},
		line:     "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue",
	},
	{
		shownCubes: []cubes{
			{red: 20, blue: 6, green: 8},
			{red: 4, blue: 5, green: 13},
			{red: 1, green: 5},
		},
		maxCubes: cubes{red: 20, blue: 6, green: 13},
		line:     "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red",
	},
	{
		shownCubes: []cubes{
			{red: 3, blue: 6, green: 1},
			{red: 6, green: 3},
			{red: 14, blue: 15, green: 3},
		},
		maxCubes: cubes{red: 14, blue: 15, green: 3},
		line:     "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red",
	},
	{
		shownCubes: []cubes{
			{red: 6, blue: 1, green: 3},
			{red: 1, blue: 2, green: 2},
		},
		maxCubes: cubes{red: 6, blue: 2, green: 3},
		line:     "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green",
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

func TestGetMaximumCubes(t *testing.T) {
	for _, data := range testInput {
		actualMaxCubes := getMaximumCubes(data.shownCubes)

		if actualMaxCubes != data.maxCubes {
			t.Errorf("Expected maxCubes to be %v, got %v", data.maxCubes, actualMaxCubes)
		}
	}
}
