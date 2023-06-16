# VegetationPeriods.jl: Determine Thermal Vegetation Periods

Julia implementation of the R pkg `vegperiod` by Robert Nuske: https://github.com/rnuske/vegperiod.

<!-- Tidyverse lifecycle badges, see https://www.tidyverse.org/lifecycle/ Uncomment or delete as needed. -->
![lifecycle](https://img.shields.io/badge/lifecycle-stable-green.svg) [![build](https://github.com/fabern/VegetationPeriods.jl/workflows/CI/badge.svg)](https://github.com/fabern/VegetationPeriods.jl/actions?query=workflow%3ACI) [![codecov.io](https://codecov.io/github/fabern/VegetationPeriods.jl/badge.svg?token=87V75HVNO0)](https://codecov.io/github/fabern/VegetationPeriods.jl)
<!-- Documentation -- uncomment or delete as needed -->
<!--
[![Documentation](https://img.shields.io/badge/docs-stable-blue.svg)](https://fabern.github.io/VegetationPeriods.jl/stable)
[![Documentation](https://img.shields.io/badge/docs-dev-blue.svg)](https://fabern.github.io/VegetationPeriods.jl/dev)
-->
## Purpose
> The vegetation period, or growing season, is the period of the year when the weather conditions are sufficient for plants to grow. This package provides methods to calculate climatological or thermal growing seasons solely based on daily mean temperatures and the day of the year (DOY). Because of their simplicity, they are commonly used in plant growth models and climate change impact assessments.
_Robert Nuske, R pkg vegperiod_

Please refer to https://github.com/rnuske/vegperiod for further information about these methods.

This package could potentially be extended with additional methods for vegetation periods that include other drivers besides daily mean temperatures. Please contact us if you're interested in the development.

## Installation
The package is registerd with the [Julia Package Registry](https://github.com/JuliaRegistries/General), hence installation is done in Julia with:
```julia
julia> import Pkg
julia> Pkg.add("VegetationPeriods")
```

## Use
```julia
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

using RCall; R"library(vegperiod); data(goe)";
@rget goe
vegperiod(
    goe.date, 
    goe.t, 
    Menzel("Picea abies (frueh)", est_prev = 2), 
    VonWilpert())

# 10×5 DataFrame
#  Row │ year   startdate   startDOY  enddate     endDOY 
#      │ Int64  Date        Int64     Date?       Int64? 
# ─────┼─────────────────────────────────────────────────
#    1 │  2001  2001-04-28       118  2001-10-01     274
#    2 │  2002  2002-05-07       127  2002-10-06     279
#    3 │  2003  2003-05-05       125  2003-10-06     279
#    4 │  2004  2004-04-25       116  2004-10-05     279
#    5 │  2005  2005-05-04       124  2005-10-02     275
#    6 │  2006  2006-05-06       126  2006-09-28     271
#    7 │  2007  2007-05-04       124  2007-10-06     279
#    8 │  2008  2008-05-04       125  2008-10-05     279
#    9 │  2009  2009-04-25       115  2009-10-06     279
#   10 │  2010  2010-04-26       116  2010-10-06     279
```

Above example shows the use of the function `vegperiod()`.
To get help for any of these check out the documentation (`?` followed by the function name) e.g. as below:

```
help?> vegperiod
search: vegperiod VegetationPeriods

  Calculate start and end date of vegetation periods based on daily average air temperature
  and the day of the year (DOY). The sum of day degrees within the vegetation period can be
  included for convenience.

  Common methods for determining the onset and end of thermal vegetation periods are provided,
  for details see the documentation of each method. Popular choices with regard to forest
  trees in Germany are Menzel and vonWilpert. Climate change impact studies at NW-FVA are
  frequently conducted using Menzel with "Picea abies (frueh)" and NuskeAlbert for all tree
  species; with tree species specifics accounted for in subsequent statistical models.

  Available methods can be queried with subtypes(VegetationStartMethod) and
  subtypes(VegetationEndMethod)

  Arguments:

    •  dates is a vector of calendar dates (object of class Date). Must contain entire
       years if est_prev > 0 else the first year may comprise only November and December.

    •  Tavg is a vector of daily average air temperatures in degree Celsius. Same length
       as dates.

    •  start_method is a VegetationStartMethod.

    •  end_method is a VegetationEndMethod.

    •  Tsum_out is a boolean. Return the sum of daily mean temperatures above Tsum_crit
       within vegetation period, also known as growing day degrees.

    •  Tsum_crit threshold for sum of day degrees. Only daily mean temperatures above
       Tsum_crit will be tallied. The default of 0 prevents negative daily temperatures
       from reducing the sum. Climate change studies often use a threshold of 5.

    •  check_data is a boolean. Perform plausibility checks on the temperature data.
       Plausible range is -35 to +40°C.

  Returns: A DataFrame with year, date and DOY of start and end day of the vegetation period
  for (each) year of the input data.
```
Or for the start method `Menzel()`:
```
help?> Menzel
search: Menzel

  Menzel(species; est_prev::Int = 0)

  The start method Menzel implements the algorithm described in Menzel (1997). The method is
  parameterized for 10 common tree species. It needs previous year's chill days.

  The argument species is required and must be one of

    •  "Larix decidua",

    •  "Picea abies (frueh)",

    •  "Picea abies (spaet)",

    •  "Picea abies (noerdl.)",

    •  "Picea omorika",

    •  "Pinus sylvestris",

    •  "Betula pubescens",

    •  "Quercus robur",

    •  "Quercus petraea",

    •  "Fagus sylvatica".

  The optional argument est_prev is the integer number of years that are used to compute the
  average number of November and December chill days as a best guess to be used to start the
  first year in case they are missing. Menzel requires the number of chill days of previous
  November and December. You can provide them e.g. by starting your time series on November
  1st (an set est_prev = 0). If the time series starts on January 1st, the previous chill days
  are not available for the first year and hennce we can either drop the first year from the
  output (happens with est_prev = 0) or estimate the number of chill days in November and
  December previous to the first year in the time series (est_prev = n).
```

## Attributions and License
This Julia package was written by [Fabian Bernhard](https://orcid.org/0000-0003-0338-0961).
The R package was created by [Robert Nuske](https://orcid.org/0000-0001-9773-2061).

Both are licensed under GPLv3.
