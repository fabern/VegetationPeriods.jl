dates   = Date("2020-01-01"):Day(1):Date("2022-12-31")
Tavg    = rand([-34.9 : 0.1 : 39.9;], length(dates))

# using RCall; R"library(vegperiod); y = 2; data(goe)";
# @rget goe
# # dates_goe   = Date("2001-01-01"):Day(1):Date("2010-12-31")
# # Tavg_goe    = rand([-34.9 : 0.1 : 39.9;], length(dates))
# dates_goe   = goe.date
# Tavg_goe    = goe.t
# print(IOContext(stdout, :compact=>false), dates_goe[1:3*365])
# print(IOContext(stdout, :compact=>false), Tavg_goe[1:3*365])
dates_goe = Date.(["2001-01-01", "2001-01-02", "2001-01-03", "2001-01-04", "2001-01-05", "2001-01-06", "2001-01-07", "2001-01-08", "2001-01-09", "2001-01-10", "2001-01-11", "2001-01-12", "2001-01-13", "2001-01-14", "2001-01-15", "2001-01-16", "2001-01-17", "2001-01-18", "2001-01-19", "2001-01-20", "2001-01-21", "2001-01-22", "2001-01-23", "2001-01-24", "2001-01-25", "2001-01-26", "2001-01-27", "2001-01-28", "2001-01-29", "2001-01-30", "2001-01-31", "2001-02-01", "2001-02-02", "2001-02-03", "2001-02-04", "2001-02-05", "2001-02-06", "2001-02-07", "2001-02-08", "2001-02-09", "2001-02-10", "2001-02-11", "2001-02-12", "2001-02-13", "2001-02-14", "2001-02-15", "2001-02-16", "2001-02-17", "2001-02-18", "2001-02-19", "2001-02-20", "2001-02-21", "2001-02-22", "2001-02-23", "2001-02-24", "2001-02-25", "2001-02-26", "2001-02-27", "2001-02-28", "2001-03-01", "2001-03-02", "2001-03-03", "2001-03-04", "2001-03-05", "2001-03-06", "2001-03-07", "2001-03-08", "2001-03-09", "2001-03-10", "2001-03-11", "2001-03-12", "2001-03-13", "2001-03-14", "2001-03-15", "2001-03-16", "2001-03-17", "2001-03-18", "2001-03-19", "2001-03-20", "2001-03-21", "2001-03-22", "2001-03-23", "2001-03-24", "2001-03-25", "2001-03-26", "2001-03-27", "2001-03-28", "2001-03-29", "2001-03-30", "2001-03-31", "2001-04-01", "2001-04-02", "2001-04-03", "2001-04-04", "2001-04-05", "2001-04-06", "2001-04-07", "2001-04-08", "2001-04-09", "2001-04-10", "2001-04-11", "2001-04-12", "2001-04-13", "2001-04-14", "2001-04-15", "2001-04-16", "2001-04-17", "2001-04-18", "2001-04-19", "2001-04-20", "2001-04-21", "2001-04-22", "2001-04-23", "2001-04-24", "2001-04-25", "2001-04-26", "2001-04-27", "2001-04-28", "2001-04-29", "2001-04-30", "2001-05-01", "2001-05-02", "2001-05-03", "2001-05-04", "2001-05-05", "2001-05-06", "2001-05-07", "2001-05-08", "2001-05-09", "2001-05-10", "2001-05-11", "2001-05-12", "2001-05-13", "2001-05-14", "2001-05-15", "2001-05-16", "2001-05-17", "2001-05-18", "2001-05-19", "2001-05-20", "2001-05-21", "2001-05-22", "2001-05-23", "2001-05-24", "2001-05-25", "2001-05-26", "2001-05-27", "2001-05-28", "2001-05-29", "2001-05-30", "2001-05-31", "2001-06-01", "2001-06-02", "2001-06-03", "2001-06-04", "2001-06-05", "2001-06-06", "2001-06-07", "2001-06-08", "2001-06-09", "2001-06-10", "2001-06-11", "2001-06-12", "2001-06-13", "2001-06-14", "2001-06-15", "2001-06-16", "2001-06-17", "2001-06-18", "2001-06-19", "2001-06-20", "2001-06-21", "2001-06-22", "2001-06-23", "2001-06-24", "2001-06-25", "2001-06-26", "2001-06-27", "2001-06-28", "2001-06-29", "2001-06-30", "2001-07-01", "2001-07-02", "2001-07-03", "2001-07-04", "2001-07-05", "2001-07-06", "2001-07-07", "2001-07-08", "2001-07-09", "2001-07-10", "2001-07-11", "2001-07-12", "2001-07-13", "2001-07-14", "2001-07-15", "2001-07-16", "2001-07-17", "2001-07-18", "2001-07-19", "2001-07-20", "2001-07-21", "2001-07-22", "2001-07-23", "2001-07-24", "2001-07-25", "2001-07-26", "2001-07-27", "2001-07-28", "2001-07-29", "2001-07-30", "2001-07-31", "2001-08-01", "2001-08-02", "2001-08-03", "2001-08-04", "2001-08-05", "2001-08-06", "2001-08-07", "2001-08-08", "2001-08-09", "2001-08-10", "2001-08-11", "2001-08-12", "2001-08-13", "2001-08-14", "2001-08-15", "2001-08-16", "2001-08-17", "2001-08-18", "2001-08-19", "2001-08-20", "2001-08-21", "2001-08-22", "2001-08-23", "2001-08-24", "2001-08-25", "2001-08-26", "2001-08-27", "2001-08-28", "2001-08-29", "2001-08-30", "2001-08-31", "2001-09-01", "2001-09-02", "2001-09-03", "2001-09-04", "2001-09-05", "2001-09-06", "2001-09-07", "2001-09-08", "2001-09-09", "2001-09-10", "2001-09-11", "2001-09-12", "2001-09-13", "2001-09-14", "2001-09-15", "2001-09-16", "2001-09-17", "2001-09-18", "2001-09-19", "2001-09-20", "2001-09-21", "2001-09-22", "2001-09-23", "2001-09-24", "2001-09-25", "2001-09-26", "2001-09-27", "2001-09-28", "2001-09-29", "2001-09-30", "2001-10-01", "2001-10-02", "2001-10-03", "2001-10-04", "2001-10-05", "2001-10-06", "2001-10-07", "2001-10-08", "2001-10-09", "2001-10-10", "2001-10-11", "2001-10-12", "2001-10-13", "2001-10-14", "2001-10-15", "2001-10-16", "2001-10-17", "2001-10-18", "2001-10-19", "2001-10-20", "2001-10-21", "2001-10-22", "2001-10-23", "2001-10-24", "2001-10-25", "2001-10-26", "2001-10-27", "2001-10-28", "2001-10-29", "2001-10-30", "2001-10-31", "2001-11-01", "2001-11-02", "2001-11-03", "2001-11-04", "2001-11-05", "2001-11-06", "2001-11-07", "2001-11-08", "2001-11-09", "2001-11-10", "2001-11-11", "2001-11-12", "2001-11-13", "2001-11-14", "2001-11-15", "2001-11-16", "2001-11-17", "2001-11-18", "2001-11-19", "2001-11-20", "2001-11-21", "2001-11-22", "2001-11-23", "2001-11-24", "2001-11-25", "2001-11-26", "2001-11-27", "2001-11-28", "2001-11-29", "2001-11-30", "2001-12-01", "2001-12-02", "2001-12-03", "2001-12-04", "2001-12-05", "2001-12-06", "2001-12-07", "2001-12-08", "2001-12-09", "2001-12-10", "2001-12-11", "2001-12-12", "2001-12-13", "2001-12-14", "2001-12-15", "2001-12-16", "2001-12-17", "2001-12-18", "2001-12-19", "2001-12-20", "2001-12-21", "2001-12-22", "2001-12-23", "2001-12-24", "2001-12-25", "2001-12-26", "2001-12-27", "2001-12-28", "2001-12-29", "2001-12-30", "2001-12-31", "2002-01-01", "2002-01-02", "2002-01-03", "2002-01-04", "2002-01-05", "2002-01-06", "2002-01-07", "2002-01-08", "2002-01-09", "2002-01-10", "2002-01-11", "2002-01-12", "2002-01-13", "2002-01-14", "2002-01-15", "2002-01-16", "2002-01-17", "2002-01-18", "2002-01-19", "2002-01-20", "2002-01-21", "2002-01-22", "2002-01-23", "2002-01-24", "2002-01-25", "2002-01-26", "2002-01-27", "2002-01-28", "2002-01-29", "2002-01-30", "2002-01-31", "2002-02-01", "2002-02-02", "2002-02-03", "2002-02-04", "2002-02-05", "2002-02-06", "2002-02-07", "2002-02-08", "2002-02-09", "2002-02-10", "2002-02-11", "2002-02-12", "2002-02-13", "2002-02-14", "2002-02-15", "2002-02-16", "2002-02-17", "2002-02-18", "2002-02-19", "2002-02-20", "2002-02-21", "2002-02-22", "2002-02-23", "2002-02-24", "2002-02-25", "2002-02-26", "2002-02-27", "2002-02-28", "2002-03-01", "2002-03-02", "2002-03-03", "2002-03-04", "2002-03-05", "2002-03-06", "2002-03-07", "2002-03-08", "2002-03-09", "2002-03-10", "2002-03-11", "2002-03-12", "2002-03-13", "2002-03-14", "2002-03-15", "2002-03-16", "2002-03-17", "2002-03-18", "2002-03-19", "2002-03-20", "2002-03-21", "2002-03-22", "2002-03-23", "2002-03-24", "2002-03-25", "2002-03-26", "2002-03-27", "2002-03-28", "2002-03-29", "2002-03-30", "2002-03-31", "2002-04-01", "2002-04-02", "2002-04-03", "2002-04-04", "2002-04-05", "2002-04-06", "2002-04-07", "2002-04-08", "2002-04-09", "2002-04-10", "2002-04-11", "2002-04-12", "2002-04-13", "2002-04-14", "2002-04-15", "2002-04-16", "2002-04-17", "2002-04-18", "2002-04-19", "2002-04-20", "2002-04-21", "2002-04-22", "2002-04-23", "2002-04-24", "2002-04-25", "2002-04-26", "2002-04-27", "2002-04-28", "2002-04-29", "2002-04-30", "2002-05-01", "2002-05-02", "2002-05-03", "2002-05-04", "2002-05-05", "2002-05-06", "2002-05-07", "2002-05-08", "2002-05-09", "2002-05-10", "2002-05-11", "2002-05-12", "2002-05-13", "2002-05-14", "2002-05-15", "2002-05-16", "2002-05-17", "2002-05-18", "2002-05-19", "2002-05-20", "2002-05-21", "2002-05-22", "2002-05-23", "2002-05-24", "2002-05-25", "2002-05-26", "2002-05-27", "2002-05-28", "2002-05-29", "2002-05-30", "2002-05-31", "2002-06-01", "2002-06-02", "2002-06-03", "2002-06-04", "2002-06-05", "2002-06-06", "2002-06-07", "2002-06-08", "2002-06-09", "2002-06-10", "2002-06-11", "2002-06-12", "2002-06-13", "2002-06-14", "2002-06-15", "2002-06-16", "2002-06-17", "2002-06-18", "2002-06-19", "2002-06-20", "2002-06-21", "2002-06-22", "2002-06-23", "2002-06-24", "2002-06-25", "2002-06-26", "2002-06-27", "2002-06-28", "2002-06-29", "2002-06-30", "2002-07-01", "2002-07-02", "2002-07-03", "2002-07-04", "2002-07-05", "2002-07-06", "2002-07-07", "2002-07-08", "2002-07-09", "2002-07-10", "2002-07-11", "2002-07-12", "2002-07-13", "2002-07-14", "2002-07-15", "2002-07-16", "2002-07-17", "2002-07-18", "2002-07-19", "2002-07-20", "2002-07-21", "2002-07-22", "2002-07-23", "2002-07-24", "2002-07-25", "2002-07-26", "2002-07-27", "2002-07-28", "2002-07-29", "2002-07-30", "2002-07-31", "2002-08-01", "2002-08-02", "2002-08-03", "2002-08-04", "2002-08-05", "2002-08-06", "2002-08-07", "2002-08-08", "2002-08-09", "2002-08-10", "2002-08-11", "2002-08-12", "2002-08-13", "2002-08-14", "2002-08-15", "2002-08-16", "2002-08-17", "2002-08-18", "2002-08-19", "2002-08-20", "2002-08-21", "2002-08-22", "2002-08-23", "2002-08-24", "2002-08-25", "2002-08-26", "2002-08-27", "2002-08-28", "2002-08-29", "2002-08-30", "2002-08-31", "2002-09-01", "2002-09-02", "2002-09-03", "2002-09-04", "2002-09-05", "2002-09-06", "2002-09-07", "2002-09-08", "2002-09-09", "2002-09-10", "2002-09-11", "2002-09-12", "2002-09-13", "2002-09-14", "2002-09-15", "2002-09-16", "2002-09-17", "2002-09-18", "2002-09-19", "2002-09-20", "2002-09-21", "2002-09-22", "2002-09-23", "2002-09-24", "2002-09-25", "2002-09-26", "2002-09-27", "2002-09-28", "2002-09-29", "2002-09-30", "2002-10-01", "2002-10-02", "2002-10-03", "2002-10-04", "2002-10-05", "2002-10-06", "2002-10-07", "2002-10-08", "2002-10-09", "2002-10-10", "2002-10-11", "2002-10-12", "2002-10-13", "2002-10-14", "2002-10-15", "2002-10-16", "2002-10-17", "2002-10-18", "2002-10-19", "2002-10-20", "2002-10-21", "2002-10-22", "2002-10-23", "2002-10-24", "2002-10-25", "2002-10-26", "2002-10-27", "2002-10-28", "2002-10-29", "2002-10-30", "2002-10-31", "2002-11-01", "2002-11-02", "2002-11-03", "2002-11-04", "2002-11-05", "2002-11-06", "2002-11-07", "2002-11-08", "2002-11-09", "2002-11-10", "2002-11-11", "2002-11-12", "2002-11-13", "2002-11-14", "2002-11-15", "2002-11-16", "2002-11-17", "2002-11-18", "2002-11-19", "2002-11-20", "2002-11-21", "2002-11-22", "2002-11-23", "2002-11-24", "2002-11-25", "2002-11-26", "2002-11-27", "2002-11-28", "2002-11-29", "2002-11-30", "2002-12-01", "2002-12-02", "2002-12-03", "2002-12-04", "2002-12-05", "2002-12-06", "2002-12-07", "2002-12-08", "2002-12-09", "2002-12-10", "2002-12-11", "2002-12-12", "2002-12-13", "2002-12-14", "2002-12-15", "2002-12-16", "2002-12-17", "2002-12-18", "2002-12-19", "2002-12-20", "2002-12-21", "2002-12-22", "2002-12-23", "2002-12-24", "2002-12-25", "2002-12-26", "2002-12-27", "2002-12-28", "2002-12-29", "2002-12-30", "2002-12-31", "2003-01-01", "2003-01-02", "2003-01-03", "2003-01-04", "2003-01-05", "2003-01-06", "2003-01-07", "2003-01-08", "2003-01-09", "2003-01-10", "2003-01-11", "2003-01-12", "2003-01-13", "2003-01-14", "2003-01-15", "2003-01-16", "2003-01-17", "2003-01-18", "2003-01-19", "2003-01-20", "2003-01-21", "2003-01-22", "2003-01-23", "2003-01-24", "2003-01-25", "2003-01-26", "2003-01-27", "2003-01-28", "2003-01-29", "2003-01-30", "2003-01-31", "2003-02-01", "2003-02-02", "2003-02-03", "2003-02-04", "2003-02-05", "2003-02-06", "2003-02-07", "2003-02-08", "2003-02-09", "2003-02-10", "2003-02-11", "2003-02-12", "2003-02-13", "2003-02-14", "2003-02-15", "2003-02-16", "2003-02-17", "2003-02-18", "2003-02-19", "2003-02-20", "2003-02-21", "2003-02-22", "2003-02-23", "2003-02-24", "2003-02-25", "2003-02-26", "2003-02-27", "2003-02-28", "2003-03-01", "2003-03-02", "2003-03-03", "2003-03-04", "2003-03-05", "2003-03-06", "2003-03-07", "2003-03-08", "2003-03-09", "2003-03-10", "2003-03-11", "2003-03-12", "2003-03-13", "2003-03-14", "2003-03-15", "2003-03-16", "2003-03-17", "2003-03-18", "2003-03-19", "2003-03-20", "2003-03-21", "2003-03-22", "2003-03-23", "2003-03-24", "2003-03-25", "2003-03-26", "2003-03-27", "2003-03-28", "2003-03-29", "2003-03-30", "2003-03-31", "2003-04-01", "2003-04-02", "2003-04-03", "2003-04-04", "2003-04-05", "2003-04-06", "2003-04-07", "2003-04-08", "2003-04-09", "2003-04-10", "2003-04-11", "2003-04-12", "2003-04-13", "2003-04-14", "2003-04-15", "2003-04-16", "2003-04-17", "2003-04-18", "2003-04-19", "2003-04-20", "2003-04-21", "2003-04-22", "2003-04-23", "2003-04-24", "2003-04-25", "2003-04-26", "2003-04-27", "2003-04-28", "2003-04-29", "2003-04-30", "2003-05-01", "2003-05-02", "2003-05-03", "2003-05-04", "2003-05-05", "2003-05-06", "2003-05-07", "2003-05-08", "2003-05-09", "2003-05-10", "2003-05-11", "2003-05-12", "2003-05-13", "2003-05-14", "2003-05-15", "2003-05-16", "2003-05-17", "2003-05-18", "2003-05-19", "2003-05-20", "2003-05-21", "2003-05-22", "2003-05-23", "2003-05-24", "2003-05-25", "2003-05-26", "2003-05-27", "2003-05-28", "2003-05-29", "2003-05-30", "2003-05-31", "2003-06-01", "2003-06-02", "2003-06-03", "2003-06-04", "2003-06-05", "2003-06-06", "2003-06-07", "2003-06-08", "2003-06-09", "2003-06-10", "2003-06-11", "2003-06-12", "2003-06-13", "2003-06-14", "2003-06-15", "2003-06-16", "2003-06-17", "2003-06-18", "2003-06-19", "2003-06-20", "2003-06-21", "2003-06-22", "2003-06-23", "2003-06-24", "2003-06-25", "2003-06-26", "2003-06-27", "2003-06-28", "2003-06-29", "2003-06-30", "2003-07-01", "2003-07-02", "2003-07-03", "2003-07-04", "2003-07-05", "2003-07-06", "2003-07-07", "2003-07-08", "2003-07-09", "2003-07-10", "2003-07-11", "2003-07-12", "2003-07-13", "2003-07-14", "2003-07-15", "2003-07-16", "2003-07-17", "2003-07-18", "2003-07-19", "2003-07-20", "2003-07-21", "2003-07-22", "2003-07-23", "2003-07-24", "2003-07-25", "2003-07-26", "2003-07-27", "2003-07-28", "2003-07-29", "2003-07-30", "2003-07-31", "2003-08-01", "2003-08-02", "2003-08-03", "2003-08-04", "2003-08-05", "2003-08-06", "2003-08-07", "2003-08-08", "2003-08-09", "2003-08-10", "2003-08-11", "2003-08-12", "2003-08-13", "2003-08-14", "2003-08-15", "2003-08-16", "2003-08-17", "2003-08-18", "2003-08-19", "2003-08-20", "2003-08-21", "2003-08-22", "2003-08-23", "2003-08-24", "2003-08-25", "2003-08-26", "2003-08-27", "2003-08-28", "2003-08-29", "2003-08-30", "2003-08-31", "2003-09-01", "2003-09-02", "2003-09-03", "2003-09-04", "2003-09-05", "2003-09-06", "2003-09-07", "2003-09-08", "2003-09-09", "2003-09-10", "2003-09-11", "2003-09-12", "2003-09-13", "2003-09-14", "2003-09-15", "2003-09-16", "2003-09-17", "2003-09-18", "2003-09-19", "2003-09-20", "2003-09-21", "2003-09-22", "2003-09-23", "2003-09-24", "2003-09-25", "2003-09-26", "2003-09-27", "2003-09-28", "2003-09-29", "2003-09-30", "2003-10-01", "2003-10-02", "2003-10-03", "2003-10-04", "2003-10-05", "2003-10-06", "2003-10-07", "2003-10-08", "2003-10-09", "2003-10-10", "2003-10-11", "2003-10-12", "2003-10-13", "2003-10-14", "2003-10-15", "2003-10-16", "2003-10-17", "2003-10-18", "2003-10-19", "2003-10-20", "2003-10-21", "2003-10-22", "2003-10-23", "2003-10-24", "2003-10-25", "2003-10-26", "2003-10-27", "2003-10-28", "2003-10-29", "2003-10-30", "2003-10-31", "2003-11-01", "2003-11-02", "2003-11-03", "2003-11-04", "2003-11-05", "2003-11-06", "2003-11-07", "2003-11-08", "2003-11-09", "2003-11-10", "2003-11-11", "2003-11-12", "2003-11-13", "2003-11-14", "2003-11-15", "2003-11-16", "2003-11-17", "2003-11-18", "2003-11-19", "2003-11-20", "2003-11-21", "2003-11-22", "2003-11-23", "2003-11-24", "2003-11-25", "2003-11-26", "2003-11-27", "2003-11-28", "2003-11-29", "2003-11-30", "2003-12-01", "2003-12-02", "2003-12-03", "2003-12-04", "2003-12-05", "2003-12-06", "2003-12-07", "2003-12-08", "2003-12-09", "2003-12-10", "2003-12-11", "2003-12-12", "2003-12-13", "2003-12-14", "2003-12-15", "2003-12-16", "2003-12-17", "2003-12-18", "2003-12-19", "2003-12-20", "2003-12-21", "2003-12-22", "2003-12-23", "2003-12-24", "2003-12-25", "2003-12-26", "2003-12-27", "2003-12-28", "2003-12-29", "2003-12-30", "2003-12-31"])
Tavg_goe = [6.2, 6.5, 3.7, 3.2, 6.8, 6.6, 5.2, 4.7, 4.5, 4.8, 6.5, 7.8, 9.1, -2.1, 0.7, 0.9, -1.4, -4.6, -4.3, -0.7, 1.2, 2.9, 4.7, 8.0, 6.5, 6.8, 8.7, 3.9, 9.0, 8.9, 11.2, 9.3, 10.5, 8.7, 9.1, 11.1, 10.6, 9.3, 11.4, 8.0, 6.2, 6.9, 9.4, 6.3, 9.2, 11.2, 7.1, 1.7, 0.8, 0.7, 1.1, 2.1, 2.9, 5.3, 0.3, 1.9, 2.6, 1.7, 3.4, 9.7, 6.4, 5.6, 4.0, -0.8, 2.6, 5.3, 6.3, 5.2, 7.9, 6.2, 7.5, 6.7, 8.2, 8.3, 5.9, 2.7, 2.2, 4.1, 8.4, 11.3, 8.6, 9.0, 9.1, 5.3, 3.0, 2.8, 1.4, 2.1, 0.6, 2.9, 6.3, 7.2, 8.3, 8.5, 10.2, 11.5, 7.7, 5.5, 1.3, 2.8, 3.1, 4.3, 5.1, 6.5, 7.1, 7.3, 5.6, 6.1, 5.9, 6.9, 9.6, 8.9, 7.6, 8.6, 10.9, 12.4, 10.7, 13.6, 10.6, 6.4, 8.7, 9.5, 10.5, 11.9, 11.0, 9.1, 8.9, 10.1, 8.0, 10.6, 14.9, 16.1, 16.5, 14.8, 14.2, 15.6, 14.0, 13.2, 16.2, 16.8, 15.7, 14.3, 15.6, 16.2, 18.0, 13.9, 15.7, 13.4, 12.6, 12.4, 12.4, 12.6, 12.7, 13.3, 12.0, 13.4, 16.3, 19.2, 19.8, 17.3, 15.6, 14.9, 15.2, 14.2, 13.7, 15.1, 14.6, 17.2, 18.8, 17.4, 22.1, 25.3, 20.4, 20.4, 17.6, 19.5, 17.6, 15.8, 15.0, 17.1, 15.5, 12.5, 12.7, 16.0, 14.7, 14.8, 15.5, 14.4, 16.2, 16.3, 16.5, 20.1, 22.7, 17.8, 16.4, 17.3, 18.4, 17.6, 19.3, 19.1, 15.4, 13.7, 13.5, 17.2, 15.1, 14.5, 16.7, 16.5, 14.8, 14.9, 19.0, 20.1, 21.8, 23.0, 21.9, 18.9, 19.5, 19.8, 19.3, 17.7, 16.7, 16.8, 16.3, 18.0, 16.1, 18.1, 17.5, 17.7, 18.0, 18.6, 19.0, 19.3, 21.1, 22.2, 22.3, 19.5, 18.4, 18.6, 20.1, 18.0, 20.7, 21.0, 20.5, 19.9, 19.6, 18.5, 15.1, 14.0, 13.9, 16.9, 16.8, 15.9, 16.3, 18.2, 19.0, 14.2, 15.1, 14.2, 12.7, 13.1, 11.5, 11.1, 14.2, 12.8, 12.9, 13.6, 12.3, 11.2, 8.4, 7.7, 6.1, 11.0, 9.1, 7.8, 11.2, 9.3, 9.5, 10.8, 12.8, 12.8, 10.9, 10.1, 5.7, 4.8, 8.1, 7.2, 5.3, 3.6, 4.1, 8.4, 10.8, 13.0, 10.3, 7.2, 6.3, 4.5, 8.2, 12.9, 11.0, 6.3, 9.2, 10.6, 10.4, 8.1, 6.7, 7.2, 3.9, 6.2, 9.2, 5.5, 6.4, 1.3, 1.5, 1.6, 5.4, 5.9, 4.5, 7.0, 8.2, 9.4, 8.1, 7.4, 8.0, 8.1, 5.2, 5.3, 3.2, 4.4, 5.0, 5.6, 6.0, 5.8, 8.0, 5.1, 8.7, 8.3, 7.3, 6.0, 5.7, 5.7, 5.5, 4.2, 0.4, -2.9, -4.7, -8.1, -8.3, -8.4, -7.0, -5.0, -2.0, -2.2, 2.2, 0.8, -0.2, -0.3, -1.4, 0.1, 0.4, 1.0, 1.3, 3.6, 3.5, 6.5, 7.0, 6.0, 3.7, -3.3, 0.0, 8.7, 6.0, -0.6, -2.3, -2.9, -5.4, -7.5, -6.0, -4.2, 0.7, 2.1, 4.3, 5.1, 4.7, 3.8, 2.6, 1.8, 2.8, 1.3, 6.2, 3.8, 2.7, 3.5, 5.1, 5.7, 2.1, 8.0, 8.8, 6.9, 6.9, 7.1, 9.4, 10.7, 6.5, 5.3, 4.7, 2.3, 1.1, -1.3, 1.0, 1.8, -1.3, -2.0, -2.5, -0.7, 0.1, 2.5, 0.4, 7.4, 5.7, 6.5, 4.3, 5.5, 3.1, 5.6, 7.7, 7.3, 6.5, 5.3, 4.3, 6.9, 7.3, 6.4, 7.3, 8.1, 7.2, 9.7, 9.6, 5.7, 3.5, 3.0, 5.3, 8.5, 2.9, 5.0, 4.8, 4.4, 5.3, 8.2, 9.3, 4.4, 4.5, 7.3, 7.4, 8.3, 4.2, 3.7, 4.1, 3.9, 2.4, 5.5, 6.3, 6.3, 5.1, 3.3, 3.7, 3.9, 8.7, 7.8, 7.7, 10.8, 10.4, 6.9, 7.5, 8.3, 11.7, 4.7, 6.4, 9.1, 3.7, 3.6, 3.3, 4.0, 6.3, 6.6, 9.0, 8.7, 10.7, 11.5, 9.1, 6.2, 5.9, 8.5, 11.6, 10.9, 11.0, 10.9, 11.7, 16.1, 18.8, 17.6, 18.1, 17.5, 16.0, 13.5, 14.4, 8.6, 11.3, 11.9, 11.6, 14.9, 10.9, 13.2, 11.3, 11.1, 14.7, 20.1, 11.9, 9.9, 11.5, 14.9, 13.2, 14.9, 16.8, 13.4, 17.4, 16.0, 12.2, 11.3, 9.7, 9.3, 11.6, 11.5, 9.9, 9.6, 12.7, 15.7, 16.1, 15.7, 16.1, 14.7, 16.8, 21.7, 17.8, 22.3, 18.3, 15.2, 15.3, 18.1, 17.9, 20.0, 21.7, 18.0, 15.2, 13.4, 17.2, 17.9, 17.4, 15.5, 15.0, 18.0, 20.4, 21.5, 22.1, 18.4, 15.3, 15.3, 19.7, 21.9, 17.5, 17.8, 18.9, 18.5, 16.3, 16.9, 17.9, 19.1, 20.7, 18.1, 20.8, 21.2, 21.6, 22.3, 18.5, 16.3, 12.9, 14.1, 15.3, 18.7, 18.8, 18.9, 15.4, 15.4, 13.4, 15.1, 18.2, 19.5, 14.1, 14.7, 15.7, 12.6, 14.4, 13.9, 16.7, 16.6, 17.0, 15.5, 14.5, 14.8, 15.6, 14.2, 16.4, 16.9, 18.0, 18.7, 12.9, 16.5, 13.4, 11.5, 12.1, 12.2, 10.2, 10.6, 11.3, 14.5, 16.6, 11.7, 13.3, 13.1, 13.1, 13.5, 11.4, 12.4, 12.3, 11.0, 13.5, 16.9, 18.2, 15.5, 14.0, 15.4, 13.5, 11.6, 13.3, 10.7, 11.6, 9.5, 11.7, 14.4, 15.6, 15.3, 15.9, 15.6, 14.8, 11.9, 12.2, 13.7, 14.9, 13.3, 6.5, 7.2, 11.4, 12.5, 11.7, 10.9, 10.0, 9.6, 11.5, 11.1, 12.5, 7.4, 4.6, 6.7, 7.4, 9.9, 8.5, 6.9, 7.6, 5.8, 1.7, -1.4, 2.5, 5.9, 4.7, 7.3, 2.6, 7.3, 7.3, 5.9, 2.1, -0.5, 2.7, 0.2, -0.6, 3.1, 4.2, 3.3, 1.3, 3.0, 1.7, 2.3, 5.8, 2.3, 0.3, 3.2, 3.3, 5.9, 5.7, 2.3, 1.2, -0.5, -8.7, -8.3, -5.7, -5.5, -0.3, 1.3, 2.5, 3.2, 0.9, 0.0, -1.4, -6.3, -1.5, 3.1, 8.8, 6.5, 5.1, 2.8, -1.4, 1.9, 1.2, -0.5, 0.3, 0.0, 3.4, 5.2, 9.2, 11.8, 10.3, 6.1, 4.8, 2.4, 0.3, -1.7, -0.8, 0.6, 2.5, 6.0, 8.8, 7.8, 3.6, 6.2, 4.8, 4.6, 5.0, 3.7, 3.8, 9.6, 4.1, 2.6, 1.5, -3.0, -1.9, -2.8, 0.9, 3.0, 4.6, 8.2, 3.5, 1.4, 0.1, -1.0, -4.0, -2.9, -4.5, -12.1, -4.4, -6.2, -0.7, 0.7, -0.5, 0.1, 4.2, 4.0, 3.3, 1.3, 1.3, 1.3, 1.4, 6.0, 6.4, 6.6, 8.0, 9.4, 9.1, 7.2, 5.4, 3.8, 1.7, 4.4, 4.5, 4.4, 1.8, 5.3, 8.5, 7.7, 4.4, 2.8, 2.0, 5.0, 4.8, 4.7, 5.1, 5.2, 4.7, 7.0, 11.1, 11.6, 7.5, 4.3, 6.6, 8.4, 10.1, 10.6, 9.4, 12.4, 11.0, 12.9, 13.2, 9.0, 8.4, 10.4, 12.4, 9.3, 7.7, 5.4, 2.8, 3.9, 5.8, 4.6, 5.3, 5.2, 6.4, 9.5, 10.4, 11.9, 10.1, 10.2, 12.0, 10.7, 9.4, 9.2, 11.8, 13.3, 10.9, 11.7, 12.6, 13.2, 10.7, 12.6, 12.3, 13.9, 14.5, 13.5, 12.2, 12.8, 11.8, 8.5, 9.4, 12.4, 14.9, 16.2, 15.2, 16.3, 11.0, 13.7, 16.7, 14.0, 14.6, 18.1, 18.4, 18.7, 18.4, 13.1, 17.8, 20.2, 17.8, 14.6, 12.8, 13.0, 16.0, 12.2, 12.4, 15.0, 12.4, 13.6, 16.3, 15.3, 17.1, 17.2, 17.7, 12.7, 14.0, 16.6, 10.6, 10.7, 12.8, 13.2, 12.2, 17.0, 18.8, 13.3, 17.1, 18.5, 18.4, 17.7, 21.9, 22.0, 22.0, 17.3, 17.2, 16.4, 17.3, 19.6, 21.4, 19.7, 19.8, 16.2, 13.9, 15.6, 18.7, 21.0, 21.6, 21.3, 18.7, 15.0, 13.8, 17.5, 19.5, 18.2, 16.9, 17.6, 18.1, 18.4, 18.8, 18.8, 19.4, 19.6, 21.0, 18.6, 19.6, 17.7, 18.2, 21.0, 18.5, 15.0, 14.5, 13.9, 15.8, 15.1, 15.2, 13.8, 15.1, 16.4, 15.1, 12.3, 11.1, 11.9, 17.4, 19.3, 18.4, 17.6, 14.5, 14.4, 15.7, 16.2, 12.7, 14.1, 16.2, 17.5, 18.8, 18.7, 17.8, 18.2, 18.4, 19.6, 18.8, 18.5, 20.4, 18.8, 18.8, 14.2, 15.1, 14.6, 19.6, 18.5, 15.8, 17.1, 17.6, 16.6, 15.9, 14.0, 16.2, 14.3, 14.6, 14.6, 14.2, 13.7, 10.9, 9.6, 9.3, 9.7, 9.1, 10.7, 13.0, 14.1, 11.4, 7.8, 5.8, 9.1, 7.8, 4.1, 2.6, 4.2, 4.0, 3.4, 5.4, 8.7, 9.8, 10.9, 11.9, 11.8, 11.4, 9.7, 10.7, 12.9, 9.8, 12.0, 11.8, 5.3, 1.8, 6.6, 7.7, 7.4, 5.6, 6.6, 6.6, 4.5, 2.4, 1.8, 2.6, -1.3, -1.8, 1.4, 0.8, 0.2, -0.7, -1.2, -0.3, 2.4, 4.3, 5.8, 6.2, 5.4, 6.6, 6.2, 7.4, 7.5, 4.4, 6.6, 3.1, 1.4, 3.8, 6.9, 6.6, 7.7, 5.9, 7.7, 7.8, 3.3, 2.8, -1.0, -0.4, 2.0, 2.0, -0.1, 0.7, 0.1, -1.4, -0.4, 4.6, 5.7, 3.2, 1.4, 0.8]
# using Plots
# plot(dates_goe[1:3*365], Tavg_goe[1:3*365])

# 1) Test user-facing API: #################################################################

# Start methods
@testset "Menzel" begin
    # Test inputs
    # works: Menzel("Larix decidua", est_prev = 2)
    # works: Menzel("Larix decidua")
    @test_throws "Provide a species" Menzel()
    @test_throws "Unknown species"  Menzel("dummy")
    @test_throws "est_prev, expected Int64" Menzel("Larix decidua", est_prev = 2.0)

    # Test values
    menzel = Menzel("Larix decidua")
    @test menzel.species == "Larix decidua"
    @test menzel.est_prev == 0
    menzel12 = Menzel("Larix decidua", est_prev = 12)
    @test menzel12.est_prev == 12

    # Test function values
    # ==> see @testset "vegetation_start" and "vegetation_end"
end
@testset "startETCCDI" begin
end
@testset "Ribes_Uva_Crispa" begin
end

# End methods
@testset "VonWilpert" begin
    vw = VonWilpert()
    @test vw isa VegetationEndMethod
end
@testset "LWF_BROOK90" begin
    # TODO
end
@testset "NuskeAlbert" begin
    # TODO
end
@testset "end_ETCCDI" begin
    # TODO
end
@testset "endStdMeteo" begin
    # TODO
end

# vegperiod()
@testset "vegperiod()" begin
    # Test input arguments #################################################################
    # works: vegperiod(dates, Tavg, Menzel("Larix decidua", est_prev=2), VonWilpert())
    @test_throws "start_method must be of type VegetationStartMethod" vegperiod(dates, Tavg, VonWilpert(), VonWilpert())
    @test_throws "end_method must be of type VegetationEndMethod"     vegperiod(dates, Tavg, Menzel("Larix decidua", est_prev=2), Menzel("Larix decidua", est_prev=2))
    @test_throws "dates must be a vector of Dates" vegperiod(1,                  Tavg, Menzel("Larix decidua", est_prev=2), VonWilpert())
    @test_throws "dates must be a vector of Dates" vegperiod(Date("2020-01-01"), Tavg, Menzel("Larix decidua", est_prev=2), VonWilpert())
    @test_throws "Tavg must be a vector of reals"  vegperiod(dates, 2, Menzel("Larix decidua", est_prev=2), VonWilpert())
    @test_throws "arguments dates and Tavg must be of same length"  vegperiod(dates, Tavg[1:end-1], Menzel("Larix decidua", est_prev=2), VonWilpert())

    # bad Tavg arguments
    @test_throws "temperature data exceeds" vegperiod(dates, Tavg .- 70, Menzel("Larix decidua", est_prev=2), VonWilpert())
    @test_throws "temperature data exceeds" vegperiod(dates, Tavg .+ 40, Menzel("Larix decidua", est_prev=2), VonWilpert())

    # bad dates arguments
    dates2 = dates[[1:10; 12:end;]];                        Tavg2 = Tavg[[1:10; 12:end;]];
    dates3 = Date("2020-01-01"):Day(1):Date("2023-01-01"); Tavg3 = rand([0.0:0.1:30.;], length(dates3));
    dates4 = Date("2020-01-02"):Day(1):Date("2022-12-31"); Tavg4 = rand([0.0:0.1:30.;], length(dates4));
    dates5 = Date("2020-11-05"):Day(1):Date("2023-12-31"); Tavg5 = rand([0.0:0.1:30.;], length(dates5));
    dates6 = Date("2020-01-01"):Day(1):Date("2023-10-03"); Tavg6 = rand([0.0:0.1:30.;], length(dates6));
    dates7 = Date("2020-01-01"):Day(1):Date("2023-10-06"); Tavg7 = rand([0.0:0.1:30.;], length(dates7));

    @test_throws "dates is not consecutive" vegperiod(
        dates2, Tavg2, Menzel("Larix decidua", est_prev=2), VonWilpert())
    @test_throws "extend at least beyond" vegperiod(
        dates3, Tavg3, Menzel("Picea abies (frueh)"), VonWilpert())
    @test_throws "at least 15 years are needed" vegperiod(
        dates4, Tavg4, Menzel("Picea abies (frueh)", est_prev=15), VonWilpert())
    @test !isempty(vegperiod(dates4, Tavg4, Menzel("Picea abies (frueh)", est_prev=0), VonWilpert())) # this works..
    @test_throws "first year must contain November and December" vegperiod(
        dates5, Tavg5, Menzel("Picea abies (frueh)"), VonWilpert())
    @test_throws "extend at least beyond" vegperiod(
        dates6, Tavg6, Menzel("Picea abies (frueh)"), VonWilpert())
    @test !isempty(vegperiod(
        dates7, Tavg7, Menzel("Picea abies (frueh)"), VonWilpert())) # this works..


    # Test return values of vegperiod()
    # TODO
end





# 2) Test internals ########################################################################
###################################################################
@testset "vegetation_start" begin
    # Menzel: =========
    res1a,res1b = Vegperiod.get_vegetation_start(dates_goe, Tavg_goe, Menzel("Picea abies (frueh)", est_prev=3), return_intermediate_results = true)
    res2a,res2b = Vegperiod.get_vegetation_start(dates_goe, Tavg_goe, Menzel("Picea abies (frueh)", est_prev=2), return_intermediate_results = true)
    res3a,res3b = Vegperiod.get_vegetation_start(dates_goe, Tavg_goe, Menzel("Picea abies (frueh)", est_prev=0), return_intermediate_results = true)
    # Test intermediate results
    @test res1a.year == [2001, 2002, 2003]
    @test res2a.year == [2001, 2002, 2003]
    @test res3a.year == [2002, 2003]
    res1c = subset(groupby(res1b, :year), [:has_started] => (s -> cumsum(s) .== 1))
    res2c = subset(groupby(res2b, :year), [:has_started] => (s -> cumsum(s) .== 1))
    res3c = subset(groupby(res3b, :year), [:has_started] => (s -> cumsum(s) .== 1))
    @test res1c.is_chillday_sumNovDec_previousYear == [58, 59, 60] # R-pkg vegperiod 0.3.1 had [58.333, 59.0, 60.0]
    @test res2c.is_chillday_sumNovDec_previousYear == [60, 59, 60] # R-pkg vegperiod 0.3.1 had [59.5, 59.0, 60.0]
    @test res3c.is_chillday_sumNovDec_previousYear == [59, 60] # R-pkg vegperiod 0.3.1 had [59.0, 60.0]
    # Test final result
    @test res1a.startDOY == [119, 127, 125]       # R-pkg vegperiod 0.3.1 had [119, 127, 125]
    @test res2a.startDOY == [118, 127, 125]       # R-pkg vegperiod 0.3.1 had [118, 127, 125]
    @test res3a.startDOY == [127, 125]       # R-pkg vegperiod 0.3.1 had [127, 125]
end

@testset "vegetation_end" begin
    # TODO
end
