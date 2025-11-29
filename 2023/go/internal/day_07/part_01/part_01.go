package part_01

import (
	"os"
	"strconv"
	"strings"
)

const USE_SAMPLE = false

type handType int

const (
	HIGH_CARD handType = iota
	PAIR
	TWO_PAIR
	THREE_OF_A_KIND
	FULL_HOUSE
	FOUR_OF_A_KIND
	FIVE_OF_A_KIND
)

func (h handType) String() string {
	return [...]string{"HIGH_CARD", "PAIR", "TWO_PAIR", "THREE_OF_A_KIND", "FULL_HOUSE", "FOUR_OF_A_KIND", "FIVE_OF_A_KIND"}[h]
}

type cardType int

const (
	TWO cardType = iota
	THREE
	FOUR
	FIVE
	SIX
	SEVEN
	EIGHT
	NINE
	TEN
	JACK
	QUEEN
	KING
	ACE
)

func (c cardType) String() string {
	return [...]string{"TWO", "THREE", "FOUR", "FIVE", "SIX", "SEVEN", "EIGHT", "NINE", "TEN", "JACK", "QUEEN", "KING", "ACE"}[c]
}

type hand struct {
	strength handType
	cards    []cardType
	bet      int
}

/**
 * Tried:
 * - 252489894 (too high)
 * - 229176554 (too low)
 * - 200253108 (too low)
 */
func Solve() {
	var filePath string
	if USE_SAMPLE {
		filePath = "../_input/day_07_part_01_sample.txt"
	} else {
		filePath = "../_input/day_07.txt"
	}
	contents, err := os.ReadFile(filePath)
	if err != nil {
		panic(err)
	}

	lines := strings.Split(string(contents), "\r\n")
	var hands []hand
	for _, line := range lines {
		if line == "" {
			continue
		}

		hands = append(hands, parseLine(line))
	}

	mappedByStrength := mapByStrength(hands)

	sortedByHighest := make(map[handType][]hand)
	for _, strength := range []handType{HIGH_CARD, PAIR, TWO_PAIR, THREE_OF_A_KIND, FULL_HOUSE, FOUR_OF_A_KIND, FIVE_OF_A_KIND} {
		if _, ok := mappedByStrength[strength]; !ok {
			continue
		}

		toBeSorted := mappedByStrength[strength]
		sortedByHighest[strength] = sortByHighest(toBeSorted)
	}

	flattened := flatten(sortedByHighest)

	answer := calculateWinnings(flattened)

	println("Answer: ", answer)
}

func parseLine(line string) hand {
	parts := strings.Split(line, " ")

	unparsedCards := strings.Split(parts[0], "")
	cards := parseCards(unparsedCards)
	strength := calculateStrength(cards)

	bet, err := strconv.Atoi(parts[1])
	if err != nil {
		panic(err)
	}

	return hand{
		strength,
		cards,
		bet,
	}
}

func parseCards(unparsedCards []string) []cardType {
	var cards []cardType
	for _, card := range unparsedCards {
		switch card {
		case "2":
			cards = append(cards, TWO)
		case "3":
			cards = append(cards, THREE)
		case "4":
			cards = append(cards, FOUR)
		case "5":
			cards = append(cards, FIVE)
		case "6":
			cards = append(cards, SIX)
		case "7":
			cards = append(cards, SEVEN)
		case "8":
			cards = append(cards, EIGHT)
		case "9":
			cards = append(cards, NINE)
		case "T":
			cards = append(cards, TEN)
		case "J":
			cards = append(cards, JACK)
		case "Q":
			cards = append(cards, QUEEN)
		case "K":
			cards = append(cards, KING)
		case "A":
			cards = append(cards, ACE)
		}
	}
	return cards
}

func calculateStrength(cards []cardType) handType {
	strength := map[cardType]int{}
	for _, card := range cards {
		if _, ok := strength[card]; !ok {
			strength[card] = 0
		}
		strength[card]++
	}

	var pairs int
	var hasThreeOfAKind bool
	for _, count := range strength {
		if count == 5 {
			return FIVE_OF_A_KIND
		}

		if count == 4 {
			return FOUR_OF_A_KIND
		}

		if count == 3 {
			hasThreeOfAKind = true
		}

		if count == 2 {
			pairs++
		}
	}

	if hasThreeOfAKind && pairs == 1 {
		return FULL_HOUSE
	}

	if hasThreeOfAKind {
		return THREE_OF_A_KIND
	}

	if pairs == 2 {
		return TWO_PAIR
	}

	if pairs == 1 {
		return PAIR
	}

	return HIGH_CARD
}

func mapByStrength(hands []hand) map[handType][]hand {

	handsByStrength := make(map[handType][]hand)
	for _, hand := range hands {
		handsByStrength[hand.strength] = append(handsByStrength[hand.strength], hand)
	}

	return handsByStrength
}

// low to high
func sortByHighest(hands []hand) []hand {
	var partition = func(arr []hand, low, high int) ([]hand, int) {
		pivot := arr[high]
		index := low

		for i := low; i < high; i++ {
			// Always 5 cards
			for j := 0; j < 5; j++ {
				if arr[i].cards[j] < pivot.cards[j] {
					arr[i], arr[index] = arr[index], arr[i]
					index++
					break
				}

				if arr[i].cards[j] != pivot.cards[j] {
					break
				}
			}
		}

		arr[high], arr[index] = arr[index], arr[high]

		return arr, index
	}

	var quickSort func(arr []hand, low, high int) []hand
	quickSort = func(arr []hand, low, high int) []hand {
		if low < high {
			arr, pivot := partition(arr, low, high)

			quickSort(arr, low, pivot-1)
			quickSort(arr, pivot+1, high)
		}

		return arr
	}

	hands = quickSort(hands, 0, len(hands)-1)

	return hands
}

func flatten(hands map[handType][]hand) []hand {
	var flat []hand
	for _, handType := range []handType{HIGH_CARD, PAIR, TWO_PAIR, THREE_OF_A_KIND, FULL_HOUSE, FOUR_OF_A_KIND, FIVE_OF_A_KIND} {
		flat = append(flat, hands[handType]...)
	}
	return flat
}

func calculateWinnings(hands []hand) int {
	var winnings int
	for i, hand := range hands {
		earned := hand.bet * (i + 1)
		winnings += earned
		println("hand ", i, ": { strength: ", hand.strength.String(), ", cards: [", hand.cards[0], hand.cards[1], hand.cards[2], hand.cards[3], hand.cards[4], "], earned: ", earned, " }")
	}
	return winnings
}
