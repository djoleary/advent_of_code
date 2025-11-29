package part_02

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

func TestProcessCards(t *testing.T) {
	cards := []Card{
		// Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
		{
			1,
			[]int{41, 48, 83, 86, 17},
			[]int{83, 86, 6, 31, 17, 9, 48, 53},
		},
		// Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
		{
			2,
			[]int{13, 32, 20, 16, 61},
			[]int{61, 30, 68, 82, 17, 32, 24, 19},
		},
		// Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
		{
			3,
			[]int{1, 21, 53, 59, 44},
			[]int{69, 82, 63, 72, 16, 21, 14, 1},
		},
		// Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
		{
			4,
			[]int{41, 92, 73, 84, 69},
			[]int{59, 84, 76, 51, 58, 5, 54, 83},
		},
		// Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
		{
			5,
			[]int{87, 83, 26, 28, 32},
			[]int{88, 30, 70, 12, 93, 22, 82, 36},
		},
		// Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
		{
			6,
			[]int{31, 18, 13, 56, 72},
			[]int{74, 77, 10, 23, 35, 67, 36, 11},
		},
	}
	dict := map[int]Card{}
	for _, card := range cards {
		dict[card.id] = card
	}
	expected := 30

	actual := processCards(dict, cards)

	if actual != expected {
		t.Errorf("ERROR: Total number of cards %d does not match expected %d", actual, expected)
	}
}

func TestCalculateNumberOfMatches(t *testing.T) {
	cards := []Card{
		// Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
		{
			1,
			[]int{41, 48, 83, 86, 17},
			[]int{83, 86, 6, 31, 17, 9, 48, 53},
		},
		// Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
		{
			2,
			[]int{13, 32, 20, 16, 61},
			[]int{61, 30, 68, 82, 17, 32, 24, 19},
		},
		// Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
		{
			3,
			[]int{1, 21, 53, 59, 44},
			[]int{69, 82, 63, 72, 16, 21, 14, 1},
		},
		// Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
		{
			4,
			[]int{41, 92, 73, 84, 69},
			[]int{59, 84, 76, 51, 58, 5, 54, 83},
		},
		// Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
		{
			5,
			[]int{87, 83, 26, 28, 32},
			[]int{88, 30, 70, 12, 93, 22, 82, 36},
		},
		// Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
		{
			6,
			[]int{31, 18, 13, 56, 72},
			[]int{74, 77, 10, 23, 35, 67, 36, 11},
		},
	}
	expected := 9

	total := 0
	for _, card := range cards {
		matches := calculateNumberOfMatches(card)
		total += matches

		cards = append(cards, card)
	}

	if total != expected {
		t.Errorf("ERROR: Score %d does not match expected %d", total, expected)
	}
}
