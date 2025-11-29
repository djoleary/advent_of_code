package part_01

import (
	"os"
	"regexp"
	"strconv"
	"strings"
)

type cubes struct {
	red   int
	blue  int
	green int
}

func Solve() {
	contents, err := os.ReadFile("../_input/day_02.txt")
	if err != nil {
		panic(err)
	}

	lines := strings.Split(string(contents), "\n")
	possibleGameIds := processLines(lines)

	println(accumulate(possibleGameIds))
}

func processLines(lines []string) []int {
	var possibleGames []int

	maxCubes := cubes{red: 12, blue: 14, green: 13}

	for _, line := range lines {
		if line == "" || line == "\n" {
			continue
		}

		shownCubes := convertLineToCubes(line)

		isPossible := isPossibleGame(shownCubes, maxCubes)
		if isPossible {
			gameId := getGameId(line)
			possibleGames = append(possibleGames, gameId)
		}
	}

	return possibleGames
}

func convertLineToCubes(line string) []cubes {
	var shownCubes []cubes

	redRegex := regexp.MustCompile(`(\d+) red`)
	blueRegex := regexp.MustCompile(`(\d+) blue`)
	greenRegex := regexp.MustCompile(`(\d+) green`)

	for _, round := range strings.Split(line, ";") {
		var cubes cubes

		redMatches := redRegex.FindStringSubmatch(round)
		if redMatches != nil {
			red, err := strconv.Atoi(redMatches[1])
			if err != nil {
				panic("Could not convert red to int: " + redMatches[1])
			} else {
				cubes.red = red
			}
		}

		blueMatches := blueRegex.FindStringSubmatch(round)
		if blueMatches != nil {
			blue, err := strconv.Atoi(blueMatches[1])
			if err != nil {
				panic("Could not convert green to int: " + blueMatches[1])
			} else {
				cubes.blue = blue
			}
		}

		greenMatches := greenRegex.FindStringSubmatch(round)
		if greenMatches != nil {
			green, err := strconv.Atoi(greenMatches[1])
			if err != nil {
				panic("Could not convert green to int: " + greenMatches[1])
			} else {
				cubes.green = green
			}
		}

		shownCubes = append(shownCubes, cubes)
	}

	return shownCubes
}

func isPossibleGame(shownCubes []cubes, maxCubes cubes) bool {
	for _, cubes := range shownCubes {
		if cubes.red > maxCubes.red {
			return false
		}

		if cubes.blue > maxCubes.blue {
			return false
		}

		if cubes.green > maxCubes.green {
			return false
		}
	}

	return true
}

func getGameId(line string) int {
	regex := regexp.MustCompile(`^Game (\d+):`)
	matches := regex.FindStringSubmatch(line)
	if matches == nil || len(matches) < 2 {
		println(matches)
		panic("No game id found in line: '" + line + "'")
	}

	gameId, err := strconv.Atoi(matches[1])
	if err != nil {
		panic("Could not convert game id to int: " + matches[1])
	}

	return gameId
}

func accumulate(gameIds []int) int {
	var acc int

	for _, gameId := range gameIds {
		acc += gameId
	}

	return acc
}
