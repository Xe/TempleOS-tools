U0 SuitToName(I64 suit) {
  switch (suit) {
  case 0:
    "Trumps";
    break;
  case 1:
    "Swords";
    break;
  case 2:
    "Wands";
    break;
  case 3:
    "Pentacles";
    break;
  case 4:
    "Cups";
    break;
  default:
    "???";
    break;
  }
}

U0 MajorToName(I64 rank) {
  switch (rank) {
  case 0:
    "The Fool";
    break;
  case 1:
    "The Magician";
    break;
  case 2:
    "The High Priestess";
    break;
  case 3:
    "The Empress";
    break;
  case 4:
    "The Emperor";
    break;
  case 5:
    "The Hierophant";
    break;
  case 6:
    "The Lovers";
    break;
  case 7:
    "The Chariot";
    break;
  case 8:
    "Strength";
    break;
  case 9:
    "The Hermit";
    break;
  case 10:
    "Wheel of Fortune";
    break;
  case 11:
    "Justice";
    break;
  case 12:
    "The Hanged Man";
    break;
  case 13:
    "Death";
    break;
  case 14:
    "Temperance";
    break;
  case 15:
    "The Devil";
    break;
  case 16:
    "The Tower";
    break;
  case 17:
    "The Star";
    break;
  case 18:
    "The Moon";
    break;
  case 19:
    "The Sun";
    break;
  case 20:
    "Judgement";
    break;
  case 21:
    "The World";
    break;
  default:
    "???";
    break;
  }
}

U0 MinorToName(I64 rank) {
  switch (rank) {
  case 0:
    "Ace";
    break;
  case 10:
    "Page";
    break;
  case 11:
    "Knight";
    break;
  case 12:
    "Queen";
    break;
  case 13:
    "King";
    break;
  default:
    "%d", rank+1;
    break;
  }
}

U0 TarotDraw() {
  I64 suit = GodBits(3, "Tarot suit");
  I64 rank = GodBits(5, "Tarot rank");

  suit = suit % 5;

  "Your draw: ";

  switch (suit) {
  case 0: // Trumps
    rank = rank % 22;
    MajorToName(rank);
    break;
  default:
    rank = rank % 14;
    MinorToName(rank);
    " of ";
    SuitToName(suit);
    break; 
  }

  "\n";
}

//TarotDraw;