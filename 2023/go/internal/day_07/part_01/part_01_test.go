package part_01

import "testing"

func TestParseLine(t *testing.T) {
	tests := map[string]struct {
		input    string
		expected hand
	}{
		"sample_1": {
			input: "32T3K 765",
			expected: hand{
				strength: PAIR,
				cards:    []cardType{THREE, TWO, TEN, THREE, KING},
				bet:      765,
			},
		},
		"sample_2": {
			input: "T55J5 684",
			expected: hand{
				strength: THREE_OF_A_KIND,
				cards:    []cardType{TEN, FIVE, FIVE, JACK, FIVE},
				bet:      684,
			},
		},
		"sample_3": {
			input: "KK677 28",
			expected: hand{
				strength: TWO_PAIR,
				cards:    []cardType{KING, KING, SIX, SEVEN, SEVEN},
				bet:      28,
			},
		},
		"sample_4": {
			input: "KTJJT 220",
			expected: hand{
				strength: TWO_PAIR,
				cards:    []cardType{KING, TEN, JACK, JACK, TEN},
				bet:      220,
			},
		},
		"sample_5": {
			input: "QQQJA 483",
			expected: hand{
				strength: THREE_OF_A_KIND,
				cards:    []cardType{QUEEN, QUEEN, QUEEN, JACK, ACE},
				bet:      483,
			},
		},
		"full_house": {
			input: "QQQAA 999",
			expected: hand{
				strength: FULL_HOUSE,
				cards:    []cardType{QUEEN, QUEEN, QUEEN, ACE, ACE},
				bet:      999,
			},
		},
	}

	for name, test := range tests {
		t.Run(name, func(t *testing.T) {
			actual := parseLine(test.input)

			if actual.strength != test.expected.strength {
				t.Errorf("Strength: expected %v, got %v", test.expected.strength, actual.strength)
			}

			if len(actual.cards) != len(test.expected.cards) {
				t.Errorf("Cards: expected %v, got %v", test.expected.cards, actual.cards)
			}

			for i, card := range actual.cards {
				if card != test.expected.cards[i] {
					t.Errorf("Card Order: expected %v, got %v", test.expected.cards, actual.cards)
				}
			}

			if actual.bet != test.expected.bet {
				t.Errorf("Bet: expected %v, got %v", test.expected.bet, actual.bet)
			}
		})
	}
}

func TestMapByStrength(t *testing.T) {
	tests := map[string]struct {
		input    []hand
		expected map[handType][]hand
	}{
		"sample": {
			input: []hand{
				{
					strength: PAIR,
					cards:    []cardType{THREE, TWO, TEN, THREE, KING},
					bet:      765,
				},
				{
					strength: THREE_OF_A_KIND,
					cards:    []cardType{TEN, FIVE, FIVE, JACK, FIVE},
					bet:      684,
				},
				{
					strength: TWO_PAIR,
					cards:    []cardType{KING, KING, SIX, SEVEN, SEVEN},
					bet:      28,
				},
				{
					strength: TWO_PAIR,
					cards:    []cardType{KING, TEN, JACK, JACK, TEN},
					bet:      220,
				},
				{
					strength: THREE_OF_A_KIND,
					cards:    []cardType{QUEEN, QUEEN, QUEEN, JACK, ACE},
					bet:      483,
				},
			},
			expected: map[handType][]hand{
				PAIR: {
					{
						strength: PAIR,
						cards:    []cardType{THREE, TWO, TEN, THREE, KING},
						bet:      765,
					},
				},
				TWO_PAIR: {
					{
						strength: TWO_PAIR,
						cards:    []cardType{KING, KING, SIX, SEVEN, SEVEN},
						bet:      28,
					},
					{
						strength: TWO_PAIR,
						cards:    []cardType{KING, TEN, JACK, JACK, TEN},
						bet:      220,
					},
				},
				THREE_OF_A_KIND: {
					{
						strength: THREE_OF_A_KIND,
						cards:    []cardType{TEN, FIVE, FIVE, JACK, FIVE},
						bet:      684,
					},
					{
						strength: THREE_OF_A_KIND,
						cards:    []cardType{QUEEN, QUEEN, QUEEN, JACK, ACE},
						bet:      483,
					},
				},
			},
		},
	}

	for name, test := range tests {
		t.Run(name, func(t *testing.T) {
			actual := mapByStrength(test.input)

			for strength, hands := range actual {
				expected := test.expected[strength]

				if len(hands) != len(expected) {
					t.Errorf("Length: expected %v, got %v", len(expected), len(hands))
				}

				for i, hand := range hands {
					if hand.strength != expected[i].strength {
						t.Errorf("Strength: expected %v, got %v", expected[i].strength, hand.strength)
					}

					if len(hand.cards) != len(expected[i].cards) {
						t.Errorf("Cards: expected %v, got %v", expected[i].cards, hand.cards)
					}

					for j, card := range hand.cards {
						if card != expected[i].cards[j] {
							t.Errorf("Card Order: expected %v, got %v", expected[i].cards, hand.cards)
						}
					}

					if hand.bet != expected[i].bet {
						t.Errorf("Bet: expected %v, got %v", expected[i].bet, hand.bet)
					}
				}
			}
		})
	}
}

func TestSortByHighest(t *testing.T) {
	tests := map[string]struct {
		input    []hand
		expected []hand
	}{
		"sample": {
			input: []hand{
				{
					strength: PAIR,
					cards:    []cardType{THREE, TWO, TEN, THREE, KING},
					bet:      765,
				},
				{
					strength: THREE_OF_A_KIND,
					cards:    []cardType{TEN, FIVE, FIVE, JACK, FIVE},
					bet:      684,
				},
				{
					strength: TWO_PAIR,
					cards:    []cardType{KING, KING, SIX, SEVEN, SEVEN},
					bet:      28,
				},
				{
					strength: TWO_PAIR,
					cards:    []cardType{KING, TEN, JACK, JACK, TEN},
					bet:      220,
				},
				{
					strength: THREE_OF_A_KIND,
					cards:    []cardType{QUEEN, QUEEN, QUEEN, JACK, ACE},
					bet:      483,
				},
			},
			expected: []hand{
				{
					strength: PAIR,
					cards:    []cardType{THREE, TWO, TEN, THREE, KING},
					bet:      765,
				},
				{
					strength: THREE_OF_A_KIND,
					cards:    []cardType{TEN, FIVE, FIVE, JACK, FIVE},
					bet:      684,
				},
				{
					strength: THREE_OF_A_KIND,
					cards:    []cardType{QUEEN, QUEEN, QUEEN, JACK, ACE},
					bet:      483,
				},
				{
					strength: TWO_PAIR,
					cards:    []cardType{KING, TEN, JACK, JACK, TEN},
					bet:      220,
				},
				{
					strength: TWO_PAIR,
					cards:    []cardType{KING, KING, SIX, SEVEN, SEVEN},
					bet:      28,
				},
			},
		},
	}

	for name, test := range tests {
		t.Run(name, func(t *testing.T) {
			actual := sortByHighest(test.input)

			if len(actual) != len(test.expected) {
				t.Errorf("Length: expected %v, got %v", len(test.expected), len(actual))
			}

			for i, hand := range actual {
				if hand.strength != test.expected[i].strength {
					t.Errorf("Strength: expected %v, got %v", test.expected[i].strength, hand.strength)
				}

				if len(hand.cards) != len(test.expected[i].cards) {
					t.Errorf("Cards: expected %v, got %v", test.expected[i].cards, hand.cards)
				}

				for j, card := range hand.cards {
					if card != test.expected[i].cards[j] {
						t.Errorf("Card Order: expected %v, got %v", test.expected[i].cards, hand.cards)
					}
				}

				if hand.bet != test.expected[i].bet {
					t.Errorf("Bet: expected %v, got %v", test.expected[i].bet, hand.bet)
				}
			}
		})
	}
}

func TestFlatten(t *testing.T) {
	tests := map[string]struct {
		input    map[handType][]hand
		expected []hand
	}{
		"sample": {
			// Order jumbled to ensure sorting works
			input: map[handType][]hand{
				TWO_PAIR: {
					{
						strength: TWO_PAIR,
						cards:    []cardType{KING, TEN, JACK, JACK, TEN},
						bet:      220,
					},
					{
						strength: TWO_PAIR,
						cards:    []cardType{KING, KING, SIX, SEVEN, SEVEN},
						bet:      28,
					},
				},
				PAIR: {
					{
						strength: PAIR,
						cards:    []cardType{THREE, TWO, TEN, THREE, KING},
						bet:      765,
					},
				},
				THREE_OF_A_KIND: {
					{
						strength: THREE_OF_A_KIND,
						cards:    []cardType{TEN, FIVE, FIVE, JACK, FIVE},
						bet:      684,
					},
					{
						strength: THREE_OF_A_KIND,
						cards:    []cardType{QUEEN, QUEEN, QUEEN, JACK, ACE},
						bet:      483,
					},
				},
			},
			expected: []hand{
				{
					strength: PAIR,
					cards:    []cardType{THREE, TWO, TEN, THREE, KING},
					bet:      765,
				},
				{
					strength: TWO_PAIR,
					cards:    []cardType{KING, TEN, JACK, JACK, TEN},
					bet:      220,
				},
				{
					strength: TWO_PAIR,
					cards:    []cardType{KING, KING, SIX, SEVEN, SEVEN},
					bet:      28,
				},
				{
					strength: THREE_OF_A_KIND,
					cards:    []cardType{TEN, FIVE, FIVE, JACK, FIVE},
					bet:      684,
				},
				{
					strength: THREE_OF_A_KIND,
					cards:    []cardType{QUEEN, QUEEN, QUEEN, JACK, ACE},
					bet:      483,
				},
			},
		},
	}

	for name, test := range tests {
		t.Run(name, func(t *testing.T) {
			actual := flatten(test.input)

			if len(actual) != len(test.expected) {
				t.Errorf("Length: expected %v, got %v", len(test.expected), len(actual))
			}

			for i, hand := range actual {
				expected := test.expected[i]

				if hand.strength != expected.strength {
					t.Errorf("Strength: expected %v, got %v", expected.strength, hand.strength)
				}

				if len(hand.cards) != len(expected.cards) {
					t.Errorf("Cards: expected %v, got %v", expected.cards, hand.cards)
				}

				for i, card := range hand.cards {
					if card != expected.cards[i] {
						t.Errorf("Card Order: expected %v, got %v", expected.cards, hand.cards)
					}
				}

				if hand.bet != expected.bet {
					t.Errorf("Bet: expected %v, got %v", expected.bet, hand.bet)
				}
			}
		})
	}
}

func TestCalculateWinnings(t *testing.T) {
	tests := map[string]struct {
		input    []hand
		expected int
	}{
		"sample": {
			input: []hand{
				{
					strength: PAIR,
					cards:    []cardType{THREE, TWO, TEN, THREE, KING},
					bet:      765,
				},
				{
					strength: TWO_PAIR,
					cards:    []cardType{KING, TEN, JACK, JACK, TEN},
					bet:      220,
				},
				{
					strength: TWO_PAIR,
					cards:    []cardType{KING, KING, SIX, SEVEN, SEVEN},
					bet:      28,
				},
				{
					strength: THREE_OF_A_KIND,
					cards:    []cardType{TEN, FIVE, FIVE, JACK, FIVE},
					bet:      684,
				},
				{
					strength: THREE_OF_A_KIND,
					cards:    []cardType{QUEEN, QUEEN, QUEEN, JACK, ACE},
					bet:      483,
				},
			},
			expected: 6440,
		},
	}

	for name, test := range tests {
		t.Run(name, func(t *testing.T) {
			actual := calculateWinnings(test.input)

			if actual != test.expected {
				t.Errorf("Winnings: expected %v, got %v", test.expected, actual)
			}
		})
	}
}
