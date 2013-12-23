# one 3 * 1000/10
# two 3
# three 5
# four 4
# five 4
# six 3
# seven 5
# eight 5
# nine 4
# 36 * 9 * 9 + 36 * 100 = 2916 + 3600 = 6516

# and (1000-100-9) * 3 = 891 * 3 = 2673

# hundred 7 * 900 = 3600

# one thousand 11

# eleven 6
# twelve 6
# thirteen 8
# fourteen 8
# fifteen 7
# sixteen 7
# seventeen 9
# eighteen 8
# nineteen 8
# 67 * 10 = 670

# twenty 6
# thirty 6
# forty 5
# fifty 5
# sixty 5
# seventy 7
# eighty 6
# ninety 6
# 46 * 10 = 460

Array.class_eval do
  def sum
    reduce(&:+)
  end
end
  
def total
  subtotals = []


  subtotals << %W[
    one two three four five six seven eight nine
  ].map(&:length).sum * (90 + 100)

  subtotals << %W[
    ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen
  ].map(&:length).sum * 10

  subtotals << %W[
    twenty thirty forty fifty sixty seventy eighty ninety
  ].map(&:length).sum * 100

  subtotals << %W[
    hundred
  ].map(&:length).sum * (9*100)

  subtotals << %W[
    and
  ].map(&:length).sum * (9*99)

  subtotals << %W[
    one thousand
  ].map(&:length).sum

  subtotals
end
