package part_01

import (
	"os"
	"slices"
	"strconv"
	"strings"
)

const USE_SAMPLE = false

type UnparsedCard struct {
	id             string
	winningNumbers []string
	haveNumbers    []string
}

type Card struct {
	id             int
	winningNumbers []int
	haveNumbers    []int
}

func (c UnparsedCard) parse() Card {
	var card Card

	id, err := strconv.Atoi(c.id)
	if err != nil {
		panic(err)
	}
	card.id = id

	for _, number := range c.winningNumbers {
		num, err := strconv.Atoi(number)
		if err != nil {
			panic(err)
		}
		card.winningNumbers = append(card.winningNumbers, num)
	}

	for _, number := range c.haveNumbers {
		num, err := strconv.Atoi(number)
		if err != nil {
			panic(err)
		}
		card.haveNumbers = append(card.haveNumbers, num)
	}

	return card
}

func Solve() {
	var contents []byte
	if USE_SAMPLE {
		contents, _ = os.ReadFile("../_input/day_04_part_01_sample.txt")
	} else {
		contents, _ = os.ReadFile("../_input/day_04.txt")
	}

	lines := strings.Split(string(contents), "\n")

	answer := 0
	for _, line := range lines {
		if line == "" || line == "\n" {
			continue
		}

		card := parseCardLine(line)
		score := tallyScore(card)

		answer += score
	}

	println(answer)
}

// "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53"
func parseCardLine(line string) Card {
	var unparsedCard UnparsedCard

	filteredLine := strings.ReplaceAll(line, "\r", "")

	// "Card 1"
	card_parts := strings.Split(filteredLine, ":")[0]
	id_parts := strings.Split(card_parts, " ")
	id := id_parts[len(id_parts)-1]
	unparsedCard.id = strings.ReplaceAll(id, " ", "")

	// "41 48 83 86 17 | 83 86  6 31 17  9 48 53"
	numbers := strings.Split(filteredLine, ":")[1]

	// " 41 48 83 86 17"
	winningNumberString := strings.Split(numbers, "|")[0]
	// ["", "41", "48", "83", "86", "17"]
	winningNumbers := strings.Split(winningNumberString, " ")
	for _, num := range winningNumbers {
		if num == "" || num == " " {
			continue
		}
		unparsedCard.winningNumbers = append(unparsedCard.winningNumbers, num)
	}

	// " 83 86  6 31 17  9 48 53"
	haveNumberString := strings.Split(numbers, "|")[1]
	// ["", "83", "86", "", "6", "31", "17", "", "9", "48", "53"]
	haveNumbers := strings.Split(haveNumberString, " ")
	for _, num := range haveNumbers {
		if num == "" || num == " " {
			continue
		}
		unparsedCard.haveNumbers = append(unparsedCard.haveNumbers, num)
	}

	return unparsedCard.parse()
}

func tallyScore(card Card) int {
	score := 0
	for _, winningNumber := range card.winningNumbers {
		if slices.Contains(card.haveNumbers, winningNumber) {
			if score == 0 {
				score = 1
			} else {
				score *= 2
			}
		}
	}

	return score
}
