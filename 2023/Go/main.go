package main

import (
	"flag"
	"os"

	"github.com/DJOLEARY/Advent_of_Code/2023/Go/internal/day_01"
	day_02_part_01 "github.com/DJOLEARY/Advent_of_Code/2023/Go/internal/day_02/part_01"
	day_02_part_02 "github.com/DJOLEARY/Advent_of_Code/2023/Go/internal/day_02/part_02"
	day_03_part_01 "github.com/DJOLEARY/Advent_of_Code/2023/Go/internal/day_03/part_01"
	day_04_part_01 "github.com/DJOLEARY/Advent_of_Code/2023/Go/internal/day_04/part_01"
	day_04_part_02 "github.com/DJOLEARY/Advent_of_Code/2023/Go/internal/day_04/part_02"
	day_06_part_01 "github.com/DJOLEARY/Advent_of_Code/2023/Go/internal/day_06/part_01"
	day_06_part_02 "github.com/DJOLEARY/Advent_of_Code/2023/Go/internal/day_06/part_02"
	day_07_part_01 "github.com/DJOLEARY/Advent_of_Code/2023/Go/internal/day_07/part_01"
	_ "github.com/outrigdev/outrig/autoinit"
)

func main() {
	day := flag.Int("day", 1, "Day to run")
	part := flag.Int("part", 2, "Part to run, must be 1 or 2")

	flag.Parse()

	if *part < 1 || *part > 2 {
		println("Invalid part number, must be 1 or 2")
		os.Exit(1)
	}

	switch *day {
	case 1:
		switch *part {
		case 1:
			println("Day 1 part 1 not implemented")
			os.Exit(1)
		case 2:
			day_01.Solve()
		}

	case 2:
		switch *part {
		case 1:
			day_02_part_01.Solve()
		case 2:
			day_02_part_02.Solve()
		}

	case 3:
		switch *part {
		case 1:
			day_03_part_01.Solve()
		case 2:
			println("Day 3 part 2 not implemented")
			os.Exit(1)
		}

	case 4:
		switch *part {
		case 1:
			day_04_part_01.Solve()
		case 2:
			day_04_part_02.Solve()
		}

	case 6:
		switch *part {
		case 1:
			day_06_part_01.Solve()
		case 2:
			day_06_part_02.Solve()
		}

	case 7:
		switch *part {
		case 1:
			day_07_part_01.Solve()
		case 2:
			println("Day 7 part 2 not implemented")
			os.Exit(1)
		}

	default:
		println("Day not implemented")
		os.Exit(1)
	}
}
