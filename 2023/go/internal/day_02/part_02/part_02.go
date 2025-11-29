package part_02

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
	answer := processLines(lines)

	println(answer)
}

func processLines(lines []string) int {
	var answer int

	for _, line := range lines {
		if line == "" || line == "\n" {
			continue
		}

		shownCubes := convertLineToCubes(line)

		maxCubes := getMaximumCubes(shownCubes)
		power := getPower(maxCubes)
		answer += power
	}

	return answer
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

func getMaximumCubes(shownCubes []cubes) cubes {
	var maxCubes cubes

	for _, cubes := range shownCubes {
		if cubes.red > maxCubes.red {
			maxCubes.red = cubes.red
		}

		if cubes.blue > maxCubes.blue {
			maxCubes.blue = cubes.blue
		}

		if cubes.green > maxCubes.green {
			maxCubes.green = cubes.green
		}
	}

	return maxCubes
}

func getPower(maxCubes cubes) int {
	return maxCubes.red * maxCubes.blue * maxCubes.green
}
