using VegetationPeriods
using Dates

dates   = Date("2018-01-01"):Day(1):Date("2022-12-31")
Tavg    = 
    30 * (0.3 .+ 1/2*cos.(dayofyear.(dates)/365 * 2π .- π)) .+ 
    rand([-34.9 : 0.1 : 39.9;]/10, length(dates))
# using Plots; plot(dates, Tavg)

vegperiod(
    dates, 
    Tavg, 
    Menzel("Picea abies (frueh)", est_prev = 2), 
    VonWilpert())

# 5×5 DataFrame
#  Row │ year   startdate   startDOY  enddate     endDOY 
#      │ Int64  Date        Int64     Date?       Int64? 
# ─────┼─────────────────────────────────────────────────
#    1 │  2018  2018-04-24       114  2018-10-03     276
#    2 │  2019  2019-04-24       114  2019-09-29     272
#    3 │  2020  2020-04-25       116  2020-10-02     276
#    4 │  2021  2021-04-25       115  2021-10-03     276
#    5 │  2022  2022-04-25       115  2022-10-02     275

#### develop
using RCall; R"library(vegperiod); y = 2; data(goe)";
@rget goe
vegperiod(
    goe.date, 
    goe.t, 
    Menzel("Picea abies (frueh)", est_prev = 2), 
    VonWilpert())
# dates_goe   = Date("2001-01-01"):Day(1):Date("2010-12-31")
# Tavg_goe    = rand([-34.9 : 0.1 : 39.9;], length(dates))
dates_goe   = goe.date
Tavg_goe    = goe.t



Menzel("Picea abies (frueh)")

VegetationPeriods.get_vegetation_start(dates_goe, Tavg_goe, Menzel("Picea abies (frueh)"))
VegetationPeriods.get_vegetation_start(dates_goe, Tavg_goe, Menzel("Picea abies (frueh)", est_prev=2))


dates = dates_goe
Tavg = Tavg_goe

res1 = VegetationPeriods.get_vegetation_end(dates_goe, Tavg_goe, VonWilpert())
res1.year == 2001:2010
# print(IOContext(stdout, :compact=>false), res1.enddate)
res1.enddate == Date.(["2001-10-01", "2002-10-06", "2003-10-06", "2004-10-05", "2005-10-02", "2006-09-28", "2007-10-06", "2008-10-05", "2009-10-06", "2010-10-06"])
# print(IOContext(stdout, :compact=>false), res1.endDOY)
res1.endDOY == [274, 279, 279, 279, 275, 271, 279, 279, 279, 279]

res1

VonWilpert()
VonWilpert(Threshold_degC = 10., LastDOY = 279)
VonWilpert(10., 279)
VonWilpert(10., 279.)

vegperiod(dates_goe, Tavg_goe, Menzel("Picea abies (frueh)"), VonWilpert())
vegperiod(dates_goe, Tavg_goe, Menzel("Picea abies (frueh)", est_prev=2), VonWilpert())
vegperiod(dates_goe, Tavg_goe, Menzel("Picea abies (frueh)", est_prev=5), VonWilpert())
vegperiod(dates_goe, Tavg_goe, Menzel("Picea abies (frueh)", est_prev=10), VonWilpert())
vegperiod(dates_goe, Tavg_goe, Menzel("Picea abies (frueh)", est_prev=18), VonWilpert())
