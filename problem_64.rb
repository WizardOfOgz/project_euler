load 'utils/gcd.rb'
require 'set'

def continued_fraction_period(square_number)
  # k = 23
  k = square_number
  d = 1
  a = ((Math.sqrt(k) - 0) / d).floor
  r = -a

  period_set = Set.new

  loop do
    d_sub = k - r ** 2

    r_prime = -r
    d_prime = k - r_prime ** 2
    a_prime = (d * ((Math.sqrt(k) + r_prime)) / d_prime).floor

    # Simplify the
    gcd_d_d_prime = Utils.gcd(d, d_prime)
    num = d / gcd_d_d_prime
    den = d_prime / gcd_d_d_prime

    new_r = r_prime - a_prime * den

    # pp({
    #   # a: a,
    #   # d: d,
    #   # r: r,
    #   # d_sub: d_sub,
    #   # r_prime: r_prime,
    #   # d_prime: d_prime,
    #   a_prime: a_prime,
    #   # num: num,
    #   # den: den,
    #   # new_r: new_r,
    # })

    a = a_prime
    d = den
    r = new_r

    # period_values = { a: a, d: d, r: r }
    period_values = { a:, d:, r: }

    # pp(period_values)

    break if period_set.include?(period_values)
    period_set.add(period_values)
  end

  period_set.size
end

# puts (10..16).map {|n| continued_fraction_period(n)}.inspect
result = (2..10_000).lazy
  .select { |n| Integer.sqrt(n) ** 2 != n } # keep only numbers which are not perfect squares
  .map { |n| continued_fraction_period(n) }
  .count { |p| p.odd? }

puts result

# # l = 8141
# # h = 12847
# #
# # # Enable tail recursion in MRI
# # RubyVM::InstructionSequence.compile_option = {
# #   tailcall_optimization: true,
# #   trace_instruction: false
# # }
# #
# # def per_month(amount, _l = l, _h = h)
# #   t = _l + _h
# #   return 0 if t <= 0
# #   1 + per_month(amount, _l - (_l.to_f / (_l + _h)) * amount * 1.00926903999091, _h - (_h.to_f / (_l + _h) * amount) * 1.00926903999091)
# # end
# #
# # # puts per_month(500, l, h)
# # # puts per_month(600, l, h)
# # # puts per_month(700, l, h)
# #
# #
# # def p(l, n, i)
# #   (l * (i/12)) / (1 - (Math::E ** (-n * Math.log(1 + (i/12)))))
# # end
# #
# #
# # def over_x_months(n = 24, _l = l, _h = h)
# #   p(_l, n, 0.0233) + p(_h, n, 0.068)
# # end
# #
# # puts l + h
# # puts over_x_months(24, l, h)
# # puts over_x_months(24, l, h) * 24
# #
# #
# # puts per_month(546.62, l, h)
# # puts over_x_months(42, l, h)
# #
# # puts over_x_months(36, l, h)
# #
# # puts per_month(650, l, h)


# 1
# --------
# ^/23 - 4

# ^/23 + 4
# --------
# 7




# ^/23 - 4
# --------
# 7 - 8^/23


# 1
# -
# 7e - 8^/23



# 1
# ----
# ^/2 - 1

# ^/2 + 1
# -------
# 1






# ==============================
# 3 + ^/14 - 3

# 1
# ----
# ^/14 - 3

# ^/14 + 3
# --------
# 5

# 1 + ^/14 -2
#     -------
#        5


#    5
# -------
# ^/14 - 2

# 5(^/14 + 2)
# ----------
#     10

# ^/14 + 2
# ----------
#     2

# 2 + ^/14 - 2
#     --------
#         2

# 2
# ----
# ^/14 - 2

# 2(^/14 + 2)
# -----------
#     10

# ^/14 + 2
# --------
#     5

# 1 +  ^/14 - 3
#       -------
#         5

# 5
# -----
# ^/14 - 3

# ^/14 + 3

# 6 + ^/14 - 3

# 1
# -----
# ^/14 - 3

# ^/14 + 3
# --------
# 5


# =~=~=~=~=~=~=~=~=~=~=~=~=~=
# ^/14 [3, (1,2,1,6)]


# =====
# ^/15

# 3 + ^/15 - 3

# ^/15 + 3
# --------
#    6

# 1 + ^/15 - 3
#     --------
#         6

# 6(^/15 + 3)
# -----------
#     6

# 6 + ^/15 - 3
#     --------
#        6

# 6
# -----
#   6

# ^/15 [3, (1,6)]


# ===
# ^/22

# *4 + ^/22 - 4

# 1
# ----
# ^/22 - 4

# ^/22 + 4
# --------
# 6

# 4 + ^/22 - 4
# ------------
#      6


# ===
# ^/24

# *4 + ^24 - 4

# 1
# --------
# ^/24 - 4

# ^/24 + 4
# --------
# 8

# 8 + ^/24 - 4
# ------------
#      8

# *1 + ^/24 - 4
#      --------
#         8

# 8
# --------
# ^/24 - 4

# 8(^/24 + 4)
# -----------
#      8

# *4 + ^/24 - 4


#    1
# --------
# ^/24 - 4
