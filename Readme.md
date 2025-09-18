# Deck Assembler for Tabletop Simulator

Simple script that combine a list of same sized pictures (allegedly cards) into an optimized grid of these.
This is made to simplify porting decks to tabletop simulator.
Note however that the limitation on deck sizes from TTS (up to 10 cards per row and 7 per column) are not yet handled.

This script is designed for unix based system.

## Setup

Simply all the script to be executed:

```{bash}
chmod +x assemble-deck.sh
```

## Usage

```{bash}
./assemble-deck.sh <list of cards> <output image name>
```
