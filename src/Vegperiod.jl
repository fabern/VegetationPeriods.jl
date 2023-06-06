module Vegperiod
export vegperiod


using Dates

"""
Calculate start and end date of vegetation periods based on daily average
air temperature and the day of the year (DOY).
The sum of day degrees within the vegetation period is included for convenience.

Common methods for determining the onset and end of thermal vegetation
periods are provided, for details see next sections. Popular choices with
regard to forest trees in Germany are `Menzel` and `vonWilpert`. Climate
change impact studies at NW-FVA are frequently conducted using `Menzel` with
"Picea abies (frueh)" and `NuskeAlbert` for all tree species; with tree
species specifics accounted for in subsequent statistical models.

#' @param dates vector of calendar dates (objects of class `Date` or something
#'   understood by [as.Date()]). Must contain entire years if `est.prev > 0`
#'   else the first year may comprise only November and December.
#' @param Tavg vector of daily average air temperatures in degree Celsius.
#'   Same length as `dates`.

#' @param start.method name of method to use for vegetation start. One of
#'   `"Menzel"` (needs additional argument `species`, see below), `"StdMeteo"`
#'   resp. `"ETCCDI"`, `"Ribes uva-crispa"`. Can be abbreviated (partial
#'   matching). For further discussion see Details.
#' @param end.method name of method to use for vegetation end. One of
#'   `"vonWilpert"`, `"LWF-BROOK90"`, `"NuskeAlbert"` and `"StdMeteo"` resp.
#'   `"ETCCDI"`. Can be abbreviated (partial matching). For further discussion
#'   see Details.

#' @param Tsum.out boolean. Return the sum of daily mean temperatures above
#'   `Tsum.crit` within vegetation period, also known as growing day degrees.
#' @param Tsum.crit threshold for sum of day degrees. Only daily mean temperatures
#'   `> Tsum.crit` will be tallied. The default of `0` prevents negative
#'   daily temperatures from reducing the sum. Climate change studies often use
#'   a threshold of `5`.

#' @param check.data Performs plausibility checks on the temperature data to
#'   ensure that the temperatures have not been multiplied by ten.
#'   Plausible range is -35 to +40°C.
#'
#' @return A data.frame with year and DOY of start and end day of
#'   vegetation period. If `Tsum.out=TRUE`, the data.frame contains an
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
#' vegperiod(dates=date, Tavg=t, Tsum.out=TRUE,
#'           start="StdMeteo", end="StdMeteo")
#' @md
#' @export
"""
function vegperiod(dates, Tavg;
    start_method = "default",
    end_method = "default",
    species = nothing,
    check_data = true)

    # start_method in ["Menzel",     "StdMeteo", "ETCCDI", "RibesUvaCrispa"]             || error("Unknown start_method: $(start_method)")
    # end_method   in ["vonWilpert", "StdMeteo", "ETCCDI", "LWF-BROOK90", "NuskeAlbert"] || error("Unknown end_method: $(end_method)")
    start_method in ["Menzel"    ] || error("Unknown start_method: $(start_method)")
    end_method   in ["vonWilpert"] || error("Unknown end_method: $(end_method)")


    # For Menzel
    ## Parse species
    if start_method == "Menzel"
        possible_species = [
            "Larix decidua", "Picea abies (frueh)",
            "Picea abies (spaet)", "Picea abies (noerdl.)",
            "Picea omorika", "Pinus sylvestris",
            "Betula pubescens", "Quercus robur",
            "Quercus petraea", "Fagus sylvatica"]
        if isnothing(species) error("Provide a species for method Menzel. Possibilities: $possible_species") end
        species in possible_species || error("Unknown species: $(species) for method Menzel. Possibilities: $possible_species")
    end

    # Parse length of Tavg and dates
    length(dates) == length(Tavg) || error("The arguments dates and Tavg must be of same length!")

    # Parse temperature values of Tavg
    !check_data || (minimum(Tavg) > -35 && maximum(Tavg) < 40) || error("""
        Your input temperature data exceeds the plausible range of -35 to +40°.
        You may want to double check your data.
        If you still want to use the given data, set `check_data` to false.""")

    # Check for consecutive days
        # Add test
        # Check for leap years



    # Compute start

    # Compute end


    return "nice!"
end


function startDOYs(start_method)
    start_method in ["Menzel"    ] || error("Unknown start_method: $(start_method)")
end

end # module Vegperiod
