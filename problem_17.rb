# Number letter counts
# https://projecteuler.net/problem=17


# If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.

# If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?

# NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.


subtotals = []


# single-digit terms are used repeated for each group of ten, except for the teens (handled separately), meaning that
# there are 9 groups of these terms for each 100 and 9 * 10 = 90 terms for our target of 1,000.
# Additionally each term is used for the hundreds quantity (e.g. "one hundred", "one hundred and one"), meaning that
# one will be used 100 times (x00—x99).
subtotals << %W[
  one two three four five six seven eight nine
].map(&:length).sum * (90 + 100)

# The teens (10—19) appear in each group of 100, or 10 times within the first 1,000 integers.
subtotals << %W[
  ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen
].map(&:length).sum * 10

# The tens quantities appear 10 times in each group of 100, or 10 * 10 = 100 times in 1,000.
subtotals << %W[
  twenty thirty forty fifty sixty seventy eighty ninety
].map(&:length).sum * 100

# "hundred" appears in every number 100—999 or 900 times.
subtotals << %W[
  hundred
].map(&:length).sum * (9*100)

# "and" is used in every number 100—999, except for the even hundreds quantities, i.e. the term appears in 99 out of
# every 100 numbers within that range, or 99 * 9 = 891
subtotals << %W[
  and
].map(&:length).sum * (9*99)

# "one thousand" is a singular case
subtotals << %W[
  one thousand
].map(&:length).sum

pp subtotals.sum
