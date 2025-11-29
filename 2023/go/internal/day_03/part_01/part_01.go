package part_01

/**
 * TRIED:
 * 530923
 */

import (
	"os"
	"strconv"
	"strings"
)

const USE_SAMPLE = true

func Solve() {
	var content []byte
	if USE_SAMPLE {
		content, _ = os.ReadFile("../_input/day_03_part_01_sample.txt")
	} else {
		content, _ = os.ReadFile("../_input/day_03.txt")
	}
	lines := strings.Split(string(content), "\n")

	validNumbers := walkLines(lines)

	answer := 0
	for _, number := range validNumbers {
		answer += number
	}

	println(answer)
}

func walkLines(lines []string) []int {
	var validNumbers []int

	for y := 0; y < len(lines); y++ {
		line := lines[y]

		if line == "" || line == "\n" {
			continue
		}

		// Counts as a symbol...
		filteredLine := strings.ReplaceAll(line, "\r", "")

		previousWasNumber := false
		number := ""
		for x := 0; x < len(filteredLine); x++ {
			char := filteredLine[x]

			_, err := strconv.Atoi(string(char))
			isNumeric := err == nil

			if isNumeric {
				previousWasNumber = true
				number += string(char)
				continue
			}

			if !previousWasNumber {
				continue
			}

			isValid := checkValidity(lines, x, y, len(number))
			if isValid {
				num, _ := strconv.Atoi(number)
				validNumbers = append(validNumbers, num)
			}

			println(number)

			previousWasNumber = false
			number = ""
		}
	}

	return validNumbers
}

// N = number
// k = numOfDigits + 1
// (x-k,y-1) (x-1,y-1) ( x ,y-1)
// (x-k, y )     N     ( x , y )
// (x-k,y+1) (x-1,y+1) ( x ,y+1)
func checkValidity(lines []string, x int, y int, numOfDigits int) bool {

	for i := max(y-1, 0); i <= y+1; i++ {

		var debugLine string

		for j := max(x-(numOfDigits+1), 0); j <= x; j++ {

			if lineExists := len(lines) > i; !lineExists {
				continue
			}

			if charExists := len(lines[i]) > j; !charExists {
				continue
			}

			char := rune(lines[i][j])
			debugLine += string(char)

			if char == '.' {
				continue
			}

			_, err := strconv.Atoi(string(char))
			isNumeric := err == nil
			if isNumeric {
				continue
			}

			debugLine = "" //nolint:ineffassign // Only used for debugging and needs to be reset

			return true
		}
	}

	return false
}
