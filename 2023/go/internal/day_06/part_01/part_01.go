package part_01

import (
	"os"
	"strconv"
	"strings"
)

const USE_SAMPLE = false

/**
 * Tried:
 * - 72128 (too low)
 * - 3317888 (correct!)
 */
func Solve() {
	var filePath string
	if USE_SAMPLE {
		filePath = "../_input/day_06_part_01_sample.txt"
	} else {
		filePath = "../_input/day_06.txt"
	}
	contents, _ := os.ReadFile(filePath)

	lines := strings.Split(string(contents), "\r\n")

	timeLine := lines[0]
	times := parseTimeLine(timeLine)

	distLine := lines[1]
	distances := parseDistanceLine(distLine)

	answer := calculateAnswer(times, distances)

	println(answer)
}

func parseTimeLine(timeLine string) []int {
	prefix := "Time:"
	return parseLine(prefix, timeLine)
}

func parseDistanceLine(distLine string) []int {
	prefix := "Distance:"
	return parseLine(prefix, distLine)
}

func parseLine(prefix string, line string) []int {
	withoutTitle := strings.TrimPrefix(line, prefix)

	numbers := []int{}
	for _, number := range strings.Split(withoutTitle, " ") {
		if number == "" {
			continue
		}
		numberInt, _ := strconv.Atoi(number)
		numbers = append(numbers, numberInt)
	}
	return numbers
}

func calculateAnswer(times []int, distances []int) int {
	answer := 1
	for i, maxTime := range times {
		recordDistance := distances[i]

		var greaterThanRecord []int
		for buttonPressedFor := 0; buttonPressedFor <= maxTime; buttonPressedFor++ {
			distance := calculateDistance(buttonPressedFor, maxTime)
			if distance > recordDistance {
				greaterThanRecord = append(greaterThanRecord, distance)
			}
		}

		if len(greaterThanRecord) > 0 {
			answer *= len(greaterThanRecord)
		}
	}

	return answer
}

func calculateDistance(buttonPressedFor int, maxTime int) int {
	return buttonPressedFor * (maxTime - buttonPressedFor)
}
