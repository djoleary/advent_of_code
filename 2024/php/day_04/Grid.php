<?php

declare(strict_types=1);

class Grid implements Stringable
{
    /**
     * @param string[][] $data
     */
    public function __construct(public array $data)
    {
    }

    public function __toString(): string
    {
        $rowToLine = fn (array $row): string => array_reduce(
            array: $row,
            callback: fn (string $acc, string $character): string => $acc . $character,
            initial: "",
        );

        return array_reduce(
            array: $this->data,
            callback: fn (string $acc, array $row): string => $acc . $rowToLine($row) . PHP_EOL,
            initial: "",
        );
    }

    public function getCharacterAtPosition(Position $position): string
    {
        if ($this->isInBounds($position)) {
            return $this->data[$position->y][$position->x];
        }

        return ".";
    }

    /**
     * @param Position[] $positions
     */
    public function getStringFromPositions(array $positions): string
    {
        $characters = array_map(
            callback: fn (Position $position): string => $this->getCharacterAtPosition($position),
            array: $positions,
        );

        $string = array_reduce(
            array: $characters,
            callback: fn (string $acc, string $character): string => $acc . $character,
            initial: "",
        );

        return $string;
    }

    public function isInBounds(Position $position): bool
    {
        if (!array_key_exists($position->y, $this->data)) {
            return false;
        }

        if (!array_key_exists($position->x, $this->data[$position->y])) {
            return false;
        }

        return true;
    }
}
