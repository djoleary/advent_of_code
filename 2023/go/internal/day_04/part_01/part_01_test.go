package part_01

import (
	"testing"
)

func TestParseCardLine(t *testing.T) {
	input := "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53"
	expected := Card{1, []int{41, 48, 83, 86, 17}, []int{83, 86, 6, 31, 17, 9, 48, 53}}

	actual := parseCardLine(input)

	if actual.id != expected.id {
		t.Errorf("ERROR: ID %d does not match expected %d", actual.id, expected.id)
	}

	if len(actual.winningNumbers) != len(expected.winningNumbers) {
		t.Errorf("ERROR: len(WinningNumbers) %d does not match expected %d", len(actual.winningNumbers), len(expected.winningNumbers))
	}

	if len(actual.haveNumbers) != len(expected.haveNumbers) {
		t.Errorf("ERROR: len(HaveNumbers) %d does not match expected %d", len(actual.haveNumbers), len(expected.haveNumbers))
	}

	for i, num := range actual.winningNumbers {
		if num != expected.winningNumbers[i] {
			t.Errorf("ERROR: WinningNumber %d does not match expected %d", num, expected.winningNumbers[i])
		}
	}

	for i, num := range actual.haveNumbers {
		if num != expected.haveNumbers[i] {
			t.Errorf("ERROR: HaveNumber %d does not match expected %d", num, expected.haveNumbers[i])
		}
	}

}

func TestTallyScore(t *testing.T) {
	card := Card{1, []int{41, 48, 83, 86, 17}, []int{83, 86, 6, 31, 17, 9, 48, 53}}
	expected := 8

	actual := tallyScore(card)

	if actual != expected {
		t.Errorf("ERROR: Score %d does not match expected %d", actual, expected)
	}
}
