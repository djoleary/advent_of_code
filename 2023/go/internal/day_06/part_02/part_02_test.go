package part_02

import "testing"

func TestParseTimeLine(t *testing.T) {
	tests := map[string]struct {
		input    string
		expected int
	}{
		"sample": {"Time:      7  15   30", 71530},
	}

	for name, test := range tests {
		t.Run(name, func(t *testing.T) {
			actual := parseTimeLine(test.input)
			if actual != test.expected {
				t.Errorf("Expected %d, got %d", test.expected, actual)
			}
		})
	}
}

func TestParseDistLine(t *testing.T) {
	tests := map[string]struct {
		input    string
		expected int
	}{
		"sample": {"Distance:  9  40  200", 940200},
	}

	for name, test := range tests {
		t.Run(name, func(t *testing.T) {
			actual := parseDistanceLine(test.input)
			if actual != test.expected {
				t.Errorf("Expected %d, got %d", test.expected, actual)
			}
		})
	}
}

func TestCalculateAnswer(t *testing.T) {
	tests := map[string]struct {
		maxTime        int
		recordDistance int
		expected       int
	}{
		"sample": {71530, 940200, 71503},
	}

	for name, test := range tests {
		t.Run(name, func(t *testing.T) {
			actual := calculateAnswer(test.maxTime, test.recordDistance)
			if actual != test.expected {
				t.Errorf("Expected %d, got %d", test.expected, actual)
			}
		})
	}
}

func TestCalculateDistance(t *testing.T) {
	tests := map[string]struct {
		maxTime          int
		buttonPressedFor int
		expected         int
	}{
		"7_7": {7, 7, 0},
		"7_6": {7, 6, 6},
		"7_5": {7, 5, 10},
		"7_4": {7, 4, 12},
		"7_3": {7, 3, 12},
		"7_2": {7, 2, 10},
		"7_1": {7, 1, 6},
		"7_0": {7, 0, 0},
	}

	for name, test := range tests {
		t.Run(name, func(t *testing.T) {
			actual := calculateDistance(test.buttonPressedFor, test.maxTime)
			if actual != test.expected {
				t.Errorf("Expected %d, got %d", test.expected, actual)
			}
		})
	}
}
