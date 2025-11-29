package part_02

import (
	"os"
	"strconv"
	"strings"
)

const USE_SAMPLE = false

/**
 * Tried:
 * - 24655068 (correct!)
 */
func Solve() {
	var filePath string
	if USE_SAMPLE {
		filePath = "../_input/day_06_part_02_sample.txt"
	} else {
		filePath = "../_input/day_06.txt"
	}
	contents, _ := os.ReadFile(filePath)

	lines := strings.Split(string(contents), "\r\n")

	timeLine := lines[0]
	time := parseTimeLine(timeLine)

	distLine := lines[1]
	distance := parseDistanceLine(distLine)

	answer := calculateAnswer(time, distance)

	println(answer)
}

func parseTimeLine(timeLine string) int {
	prefix := "Time:"
	return parseLine(prefix, timeLine)
}

func parseDistanceLine(distLine string) int {
	prefix := "Distance:"
	return parseLine(prefix, distLine)
}

func parseLine(prefix string, line string) int {
	withoutTitle := strings.TrimPrefix(line, prefix)

	numbers := []string{}
	for _, number := range strings.Split(withoutTitle, " ") {
		if number == "" {
			continue
		}
		numbers = append(numbers, number)
	}

	number := strings.Join(numbers, "")
	numberInt, err := strconv.Atoi(number)
	if err != nil {
		panic(err)
	}

	return numberInt
}

func calculateAnswer(maxTime int, recordDistance int) int {
	var greaterThanRecord []int
	for buttonPressedFor := 0; buttonPressedFor <= maxTime; buttonPressedFor++ {
		distance := calculateDistance(buttonPressedFor, maxTime)
		if distance > recordDistance {
			greaterThanRecord = append(greaterThanRecord, distance)
		}
	}

	return len(greaterThanRecord)
}

func calculateDistance(buttonPressedFor int, maxTime int) int {
	return buttonPressedFor * (maxTime - buttonPressedFor)
}
