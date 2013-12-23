MonthDays = [31,28,31,30,31,30,31,31,30,31,30,31]

def pe19
  days = 2
  current_month = 0
  current_year = 1901
  num_month_beginning_on_sunday = 0

  while current_year < 2001
    days = (days + numDaysInMonth(current_month, current_year)) % 7
    num_month_beginning_on_sunday += 1 if days==0
    current_month = (current_month + 1) % 12
    current_year += 1 if current_month == 0
  end

  num_month_beginning_on_sunday
end

def numDaysInMonth(month,year)
  if year % 4 == 0 && (year % 100 != 0 || year % 400 == 0) && month == 1
    29
  else
    MonthDays[month]
  end
end