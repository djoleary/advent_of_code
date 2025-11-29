<?php

declare(strict_types=1);

class Input
{
    public string $contents;

    public function __construct(private string $fileName)
    {
        $contents = file_get_contents($this->fileName, use_include_path: true);
        $this->contents = $contents === false ? "" : $contents;
    }

    public function toGrid(): Grid
    {
        $lines = explode("\n", $this->contents);
        $gridArray = array_map(
            callback: fn (string $line): array => str_split(trim($line)),
            array: $lines
        );

        return new Grid($gridArray);
    }
}
