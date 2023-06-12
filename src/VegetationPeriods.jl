module VegetationPeriods
export vegperiod, VegetationStartMethod, VegetationEndMethod
export Menzel, startETCCDI, Ribes_Uva_Crispa                         # VegetationStartMethods
export VonWilpert, LWF_BROOK90, NuskeAlbert, end_ETCCDI, endStdMeteo # VegetationEndMethods

using Dates
using DataFrames
using DataFramesMeta
import Statistics: mean
import StatsBase: rle, inverse_rle # for VonWilpert


abstract type VegetationStartMethod end
abstract type VegetationEndMethod end

include("methods.jl")


"""
Calculate start and end date of vegetation periods based on daily average
air temperature and the day of the year (DOY).
The sum of day degrees within the vegetation period can be included for convenience.

Common methods for determining the onset and end of thermal vegetation
periods are provided, for details see the documentation of each method.
Popular choices with regard to forest trees in Germany are `Menzel` and `vonWilpert`.
Climate change impact studies at NW-FVA are frequently conducted using `Menzel` with
"Picea abies (frueh)" and `NuskeAlbert` for all tree species; with tree
species specifics accounted for in subsequent statistical models.

Available methods can be queried with `subtypes(VegetationStartMethod)` and `subtypes(VegetationEndMethod)`

Arguments:
- `dates`  is a vector of calendar dates (object of class `Date`). Must contain
entire years if `est_prev > 0` else the first year may comprise only November and December.
- `Tavg` is a vector of daily average air temperatures in degree Celsius. Same length as `dates`.

- `start_method` is a VegetationStartMethod.
- `end_method` is a VegetationEndMethod.
- `Tsum_out` is a boolean. Return the sum of daily mean temperatures above
   `Tsum_crit` within vegetation period, also known as growing day degrees.
- `Tsum_crit threshold for sum of day degrees. Only daily mean temperatures `> Tsum_crit`
    will be tallied. The default of `0` prevents negative daily temperatures from reducing the sum.
    Climate change studies often use a threshold of `5`.
- check.data is a boolean. Perform plausibility checks on the temperature data.
    Plausible range is -35 to +40°C.


#' @return A data.frame with year and DOY of start and end day of
#'   vegetation period. If `Tsum_out=TRUE`, the data.frame contains an
#'   additional column with the sum of day degrees within vegetation periods.
#'

#' @examples
#' data(goe)
#' vegperiod(dates=date, Tavg=t,
#'           start.method="Menzel", end.method="vonWilpert",
#'           species="Picea abies (frueh)", est.prev=5)
#'
#' # take chill days from first year, which is then dropped
#' vegperiod(dates=date, Tavg=t, start="Menzel", end="vonWilpert",
#'           species="Picea abies (frueh)", est.prev=0)
#'
#' # add column with sum of day degrees in vegetation periods
#' vegperiod(dates=date, Tavg=t, Tsum_out=TRUE,
#'           start="StdMeteo", end="StdMeteo")
#' @md
#' @export
"""
function vegperiod(
    dates,
    Tavg,
    start_method,
    end_method;
    check_data = true)

    # Check input types
    start_method isa VegetationStartMethod || error("""
        The argument start_method must be of type VegetationStartMethod. Check available methods with: `subtypes(VegetationStartMethod)`""")
    end_method   isa VegetationEndMethod   || error("""
        The argument end_method must be of type VegetationEndMethod. Check available methods with: `subtypes(VegetationEndMethod)`""")

    dates isa AbstractArray || eltype(dates) == Date || error("""
        The argument dates must be a vector of Dates, e.g. `[Date(\"2023-06-06\")]`""")
    Tavg isa AbstractArray  || eltype(Tavg)  == Real || error("""
        The argument Tavg must be a vector of reals.""")
    length(dates) == length(Tavg) || error("""
        The arguments dates and Tavg must be of same length!""")

    # Check input values
    # Check Tavg (only if requested)
    if check_data
        # Parse temperature values of Tavg
        (minimum(Tavg) > -35 && maximum(Tavg) < 40) || error("""
            Your input temperature data exceeds the plausible range of -35 to +40°.
            You may want to double check your data.
            If you still want to use the given data, set `check_data` to false.""")
    end

    # Check dates
    # a) Check for continuous/consecutive/ordered dates
    idx_gap = findall(diff(dates) .!= Day(1))
    if !isempty(idx_gap)
        gaps = dates[sort([idx_gap; idx_gap .+ 1;])]
        error("The argument dates is not consecutive or ordered. There are gaps at position(s) $idx_gap: \n $(gaps)")
    end
    # b) Check for complete years
    # Check starting date of first year
    if typeof(start_method) == Menzel
        if start_method.est_prev == 0
            dates[1] < Date(year(dates[1]), 11, 01) || error(
                "With `Menzel(..., est_prev == 0)` the first year must contain November and December. Current start date is: $(dates[1])")
        else
            n_year_needed = start_method.est_prev
            n_year_available = length(unique(year.(dates)))
            n_year_needed <= n_year_available || error(
                "With `Menzel(..., est_prev == $n_year_needed)` at least $n_year_needed years are needed in the argument `dates`. Got $n_year_available. ")
        end
    else
        dates[1] == Date(year(dates[1]), 01, 01)
        error("First year must start on January 01st. Current start date is: $(dates[1])")
    end
    # Check ending date of last year
    dates[end] > Date(year(dates[end]), 10, 05) || error(
        "Last year must extend at least beyond October 5th. Current end date is: $(dates[end])")


    # Compute start
    start_dates = get_vegetation_start(dates, Tavg, start_method)

    # Compute end
    end_dates = get_vegetation_end(dates, Tavg, end_method)

    # Combine start and end dates
    return leftjoin(start_dates, end_dates, on = [:year])

end

"""
    get_vegetation_start(dates, Tavg, start_method)

Function to get a data frame with start dates of vegetation period for each year.
Takes thre mandatory arguments `dates` and `Tavg` (see documentation for `vegperiod`), and
`start_method` (a `VegetationStartMethod`).

Returns a `DataFrame` with columns `year`, `startdate`, `startDOY`.

Depending on `start_method` additional optional arguments are possible, mostly for internal
testing purposes.
"""
function get_vegetation_start(dates, Tavg, start_method::VegetationStartMethod)
    @warn "Unspecified method"
    return DataFrame(year = 1, startdate = Date("2001-01-01"), startDOY = 1)
end

"""
    get_vegetation_end(dates, Tavg, end_method)

Function to get a data frame with end dates of vegetation period for each year.
Takes thre mandatory arguments `dates` and `Tavg` (see documentation for `vegperiod`), and
`end_method` (a `VegetationEndMethod`).

Returns a `DataFrame` with columns `year`, `enddate`, `endDOY`.

Depending on `end_method` additional optional arguments are possible, mostly for internal
testing purposes.
"""
function get_vegetation_end(dates, Tavg, end_method::VegetationEndMethod)
    @warn "Unspecified method"
    return DataFrame(year = 1, enddate = Date("2001-12-31"), endDOY = 365)
end


end # module VegetationPeriods
