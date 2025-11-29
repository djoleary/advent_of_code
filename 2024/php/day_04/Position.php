<?php

declare(strict_types=1);

class Position implements Stringable
{
    public function __construct(public $x, public $y)
    {
    }

    public function __toString(): string
    {
        return "({$this->x}, {$this->y})";
    }

    /**
     * Not validated
     */
    public function getNorth(): self
    {
        return new self($this->x, $this->y - 1);
    }

    /**
     * Not validated
     */
    public function getNorthEast(): self
    {
        return new self($this->x + 1, $this->y - 1);
    }

    /**
     * Not validated
     */
    public function getEast(): self
    {
        return new self($this->x + 1, $this->y);
    }

    /**
     * Not validated
     */
    public function getSouthEast(): self
    {
        return new self($this->x + 1, $this->y + 1);
    }

    /**
     * Not validated
     */
    public function getSouth(): self
    {
        return new self($this->x, $this->y + 1);
    }

    /**
     * Not validated
     */
    public function getSouthWest(): self
    {
        return new self($this->x - 1, $this->y + 1);
    }

    /**
     * Not validated
     */
    public function getWest(): self
    {
        return new self($this->x - 1, $this->y);
    }

    /**
     * Not validated
     */
    public function getNorthWest(): self
    {
        return new self($this->x - 1, $this->y - 1);
    }
}
