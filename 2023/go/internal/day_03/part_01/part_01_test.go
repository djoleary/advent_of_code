package part_01

import (
	"os"
	"strings"
	"testing"
)

func TestWalkLines(t *testing.T) {
	lines := getSampleLines()
	expected := 4361

	validNumbers := walkLines(lines)

	actual := 0
	for _, number := range validNumbers {
		actual += number
	}

	if actual != expected {
		t.Errorf("Expected answer to be %d, got %d", expected, actual)
	}
}

func TestCheckValidity(t *testing.T) {
	lines := getSampleLines()

	tests := []struct {
		x        int
		y        int
		length   int
		expected bool
	}{
		{3, 0, 3, true},  // 467
		{8, 0, 3, false}, // 114
		{9, 0, 1, false}, //   3 - Added to check for '\r' counting as a symbol
		{4, 2, 2, true},  //  35
		{9, 2, 3, true},  // 633
		{9, 3, 1, false}, //   3 - Added to check if number continues to next line
		{3, 4, 3, true},  // 617
		{9, 5, 2, false}, //  58
		{5, 6, 3, true},  // 592
		{9, 7, 3, true},  // 775
		{4, 9, 3, true},  // 664
		{8, 9, 3, true},  // 598
	}

	for _, test := range tests {
		actual := checkValidity(lines, test.x, test.y, test.length)

		if actual != test.expected {
			t.Errorf("Expected %d, %d, %d to be %t, got %t", test.x, test.y, test.length, test.expected, actual)
		}
	}
}

func getSampleLines() []string {
	contents, err := os.ReadFile("../../../../_input/day_03_part_01_sample.txt")
	if err != nil {
		panic(err)
	}

	lines := strings.Split(string(contents), "\n")

	var filteredLines []string
	for _, line := range lines {
		if line == "" || line == "\n" {
			continue
		}

		// Counts as a symbol...
		filteredLine := strings.ReplaceAll(line, "\r", "")

		filteredLines = append(filteredLines, filteredLine)
	}

	return filteredLines
}
