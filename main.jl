using Vegperiod
using Dates


# dates = Date.(["2022-12-29", "2022-12-30", "2022-12-31"])
dates   = Date("2020-01-01"):Day(1):Date("2022-12-31")
# Tavg  = [5.1, 5.5, 10.0]
Tavg    = rand([0.0:0.1:30.;], length(dates))
vegperiod(dates, Tavg; start_method = "Menzel", end_method = "vonWilpert")

vegperiod()

vegperiod(; start_method = "Menzel", end_method = "vonWilpert")
