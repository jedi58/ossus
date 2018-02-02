```regexp
[A-PR-UWYZ][A-HK-Y]?[0-9]{1,2}[A-HJKSTUW]?\s?[0-9][ABD-HJLNP-UW-Z]{2}
```
**Note:** This will verify the syntax for a postcode is correct, not that the postcode itself exists.

As detailed by: https://www.mrs.org.uk/pdf/postcodeformat.pdf

- The first one or two letters are the area which will be one of 124 different postcode *areas* in the UK.
- The number(s) following this is the *district*
- The first number in the second block is the *sector*
- The final two characters are the *unit* - there are usually around 15 addresses per unit

| FORMAT   | EXAMPLE |
|----------|---------|
| AN NAA   | M1 1AA  |
| ANN NAA  | M60 1NW |
| AAN NAA  | CR2 6XH |
| AANN NAA | DN55 1PT|
| ANA NAA  | W1A 1HQ |
| AANA NAA | EC1A 1BB|

- The letters Q, V and X are not used in the first position
- The letters I,J and Z are not used in the second position.
- The only letters to appear in the third position are A, B, C, D, E, F, G, H, J, K, S, T, U and W.
- The second half of the postcode is always consistent numeric, alpha, alpha format and the letters C, I, K, M, O and
V are never used.

Postcodes should always be in BLOCK CAPITALS as the last line of an address. Do not underline the postcode or use
any punctuation. Leave a clear space of one character between the two parts of the postcode and do not join the
characters in any way.
