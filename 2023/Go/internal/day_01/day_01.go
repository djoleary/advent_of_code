package day_01

import (
	"errors"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func Solve() {
	filename := "../_input/day_01.txt"
	content := readFile(filename)

	numbers := []int{}

	lines := strings.Split(content, "\n")
	for _, line := range lines {
		first_num, last_num, err := findNumbers(line)
		if err != nil {
			continue
		}

		num_str := first_num + last_num
		num := strToInt(num_str)
		numbers = append(numbers, num)
	}

	acc := accumulate(numbers)

	fmt.Println(acc)
}

func readFile(filename string) string {
	content, err := os.ReadFile(filename)
	if err != nil {
		panic(err)
	}

	return string(content)
}

var num_map = map[string]string{
	"zero":  "0",
	"0":     "0",
	"one":   "1",
	"1":     "1",
	"two":   "2",
	"2":     "2",
	"three": "3",
	"3":     "3",
	"four":  "4",
	"4":     "4",
	"five":  "5",
	"5":     "5",
	"six":   "6",
	"6":     "6",
	"seven": "7",
	"7":     "7",
	"eight": "8",
	"8":     "8",
	"nine":  "9",
	"9":     "9",
}

func findNumbers(line string) (string, string, error) {
	if line == "" || line == "\n" {
		return "", "", errors.New("Empty line")
	}

	found_numbers := []string{}
	window_size := 5
	for i := range line {
		window_end := i + window_size
		if window_end > len(line) {
			window_end = len(line)
		}
		sub_str := line[i:window_end]

		for key, value := range num_map {
			if strings.HasPrefix(sub_str, key) {
				found_numbers = append(found_numbers, value)
			}
		}
	}

	if len(found_numbers) == 0 {
		return "", "", errors.New("No numbers found")
	}

	first := found_numbers[0]
	last := found_numbers[len(found_numbers)-1]

	return first, last, nil
}

func accumulate(numbers []int) int {
	acc := 0

	for _, num := range numbers {
		acc += num
	}

	return acc
}

func strToInt(str string) int {
	num, err := strconv.ParseInt(str, 0, 0)
	if err != nil {
		panic(err)
	}

	return int(num)
}
