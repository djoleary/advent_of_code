<?php

declare(strict_types=1);

spl_autoload_register(fn (string $className) => require "{$className}.php");

// Assumes executed from workspace root
$input = new Input('../_input/day_04.txt');
if ($input->contents === "") {
    throw new RuntimeException("File not found");
}

$grid = $input->toGrid();

$matchCount = 0;
foreach ($grid->data as $y => $row) {
    foreach ($row as $x => $char) {
        if ($char !== 'X') {
            continue;
        }

        $start = new Position($x, $y);

        $possibleMatches = [];

        $possibleMatches["north"] = $grid->getStringFromPositions([
            $start,
            $start->getNorth(),
            $start->getNorth()->getNorth(),
            $start->getNorth()->getNorth()->getNorth(),
        ]);

        $possibleMatches["east"] = $grid->getStringFromPositions([
            $start,
            $start->getEast(),
            $start->getEast()->getEast(),
            $start->getEast()->getEast()->getEast(),
        ]);

        $possibleMatches["south"] = $grid->getStringFromPositions([
            $start,
            $start->getSouth(),
            $start->getSouth()->getSouth(),
            $start->getSouth()->getSouth()->getSouth(),
        ]);

        $possibleMatches["west"] = $grid->getStringFromPositions([
            $start,
            $start->getWest(),
            $start->getWest()->getWest(),
            $start->getWest()->getWest()->getWest(),
        ]);

        $possibleMatches["north-east"] = $grid->getStringFromPositions([
            $start,
            $start->getNorthEast(),
            $start->getNorthEast()->getNorthEast(),
            $start->getNorthEast()->getNorthEast()->getNorthEast(),
        ]);

        $possibleMatches["north-west"] = $grid->getStringFromPositions([
            $start,
            $start->getNorthWest(),
            $start->getNorthWest()->getNorthWest(),
            $start->getNorthWest()->getNorthWest()->getNorthWest(),
        ]);

        $possibleMatches["south-east"] = $grid->getStringFromPositions([
            $start,
            $start->getSouthEast(),
            $start->getSouthEast()->getSouthEast(),
            $start->getSouthEast()->getSouthEast()->getSouthEast(),
        ]);

        $possibleMatches["south-west"] = $grid->getStringFromPositions([
            $start,
            $start->getSouthWest(),
            $start->getSouthWest()->getSouthWest(),
            $start->getSouthWest()->getSouthWest()->getSouthWest(),
        ]);

        $matchCount += array_reduce(
            array: $possibleMatches,
            callback: fn (int $acc, string $possibleMatch): int => match ($possibleMatch) {
                "XMAS" => $acc + 1,
                default => $acc,
            },
            initial: 0,
        );
    }
}

// ANSWER: 2517
echo $matchCount;
