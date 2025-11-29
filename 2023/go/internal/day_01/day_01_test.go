package day_01

import (
	"testing"
)

type input string
type answer string

func TestFindNumbers(t *testing.T) {
	data := map[input]answer{
		"1abc2":       "12",
		"pqr3stu8vwx": "38",
		"a1b2c3d4e5f": "15",
		"treb7uchet":  "77",
	}

	for input, expected := range data {
		actual_first, actual_last, err := findNumbers(string(input))

		if err != nil {
			t.Error("find_numbers returned an error")
		}

		actual := actual_first + actual_last

		if actual != string(expected) {
			t.Errorf("Expected %s, got %s", expected, actual)
		}
	}
}
