abstract type VegetationStartMethod end
abstract type VegetationEndMethod end

# Start methods ############################################################################
"""
    Menzel(species; est_prev::Int = 0)

The start method `Menzel` implements the algorithm described in
Menzel (1997). The method is parameterized for 10 common tree species. It
needs previous year's chill days.

The argument `species` is required and must be one of
- `"Larix decidua"`,
- `"Picea abies (frueh)"`,
- `"Picea abies (spaet)"`,
- `"Picea abies (noerdl.)"`,
- `"Picea omorika"`,
- `"Pinus sylvestris"`,
- `"Betula pubescens"`,
- `"Quercus robur"`,
- `"Quercus petraea"`,
- `"Fagus sylvatica"`.

The optional argument `est_prev` is the integer number of years to **est**imate **prev**ious
year's chill days for the first year.
`Menzel` requires the number of chill days of previous November and December.
With `est_prev = 0` the first year in the time series is used as previous year and dropped from
the time series. To keep the first year, chill days from the previous year can be estimated
as an average of the first `n` years, when setting argument `est_prev = n`.

## Reference
Menzel, A. (1997)
Phänologie von Waldbäumen unter sich ändernden Klimabedingungen -
Auswertung der Beobachtungen in den Internationalen Phänologischen Gärten
und Möglichkeiten der Modellierung von Phänodaten.
*Forstliche Forschungsberichte München*.
"""
struct Menzel{} <: VegetationStartMethod
    species
    est_prev
    parameter
end
function Menzel(species = nothing; est_prev::Int = 0) # constructor function
    # Parse species
    species_parameters = Dict([
                                   #cold days, hot days,
        ("Larix decidua",          (TbCD = 7, TbH = 3, a = 1372, b = -246)),
        ("Picea abies (frueh)" ,   (TbCD = 9, TbH = 4, a = 1848, b = -317)),
        ("Picea abies (spaet)" ,   (TbCD = 9, TbH = 5, a = 1616, b = -274)),
        ("Picea abies (noerdl.)",  (TbCD = 9, TbH = 4, a = 2084, b = -350)),
        ("Picea omorika",          (TbCD = 7, TbH = 3, a = 2833, b = -484)),
        ("Pinus sylvestris",       (TbCD = 9, TbH = 5, a = 1395, b = -223)),
        ("Betula pubescens",       (TbCD = 9, TbH = 5, a = 1438, b = -261)),
        ("Quercus robur",          (TbCD = 9, TbH = 4, a = 1748, b = -298)),
        ("Quercus petraea",        (TbCD = 9, TbH = 3, a = 1741, b = -282)),
        ("Fagus sylvatica",        (TbCD = 9,  TbH = 6, a = 1922, b = -348))])
    possible_species = keys(species_parameters)

    if isnothing(species) error("Provide a species as first arguments for method Menzel. Possibilities: $possible_species") end

    species in possible_species || error(
        "Unknown species: $(species) for method Menzel. Possible: $possible_species")

    Menzel(species, est_prev, species_parameters[species])
end
function Base.show(io::IO, meth::Menzel) # constructor function
    print(io, "Menzel(species = \"$(meth.species)\", est_prev = $(meth.est_prev))")
end

"""
    startETCCDI()

The start method `startETCCDI` resp. `startStdMeteo` is a simple threshold based procedure as defined
by the Expert Team on Climate Change Detection and Indices (cf. ETCCDI 2009, Frich
et al. 2002, Zhang et al. 2011) leading to quite early vegetation starts.
This method is widely used in climate change studies.

**Not yet implemented!**

## Reference
ETCCDI (2009)
Climate Change Indices: Definitions of the 27 core indices.
http://etccdi.pacificclimate.org/list_27_indices.shtml

Frich, P., Alexander, L., Della-Marta, P., Gleason, B., Haylock, M.,
Klein Tank, A. and Peterson, T. (2002)
Observed coherent changes in climatic extremes during the second half of
the twentieth century.
*Climate Research*, **19**, 193--212.
10.3354/cr019193.

Zhang, X., Alexander, L., Hegerl, G. C., Jones, P., Tank, A. K.,
Peterson, T. C., Trewin, B. and Zwiers, F. W. (2011)
Indices for monitoring changes in extremes based on daily temperature and
precipitation data.
*Wiley Interdisciplinary Reviews: Climate Change*, **(6)**, 851--870.
10.1002/wcc.147.
"""
struct startETCCDI{} <: VegetationStartMethod
end
# function startETCCDI() # constructor function # remove if not needed for implementation
#     error("Not yet implemented")
#     startETCCDI()
# end

"""
    startStdMeteo()

The start method `startETCCDI` resp. `startStdMeteo` is a simple threshold based procedure as defined
by the Expert Team on Climate Change Detection and Indices (cf. ETCCDI 2009, Frich
et al. 2002, Zhang et al. 2011) leading to quite early vegetation starts.
This method is widely used in climate change studies.

**Not yet implemented!**

## Reference
ETCCDI (2009)
Climate Change Indices: Definitions of the 27 core indices.
http://etccdi.pacificclimate.org/list_27_indices.shtml

Frich, P., Alexander, L., Della-Marta, P., Gleason, B., Haylock, M.,
Klein Tank, A. and Peterson, T. (2002)
Observed coherent changes in climatic extremes during the second half of
the twentieth century.
*Climate Research*, **19**, 193--212.
10.3354/cr019193.

Zhang, X., Alexander, L., Hegerl, G. C., Jones, P., Tank, A. K.,
Peterson, T. C., Trewin, B. and Zwiers, F. W. (2011)
Indices for monitoring changes in extremes based on daily temperature and
precipitation data.
*Wiley Interdisciplinary Reviews: Climate Change*, **(6)**, 851--870.
10.1002/wcc.147.
"""
struct startStdMeteo{} <: VegetationStartMethod

end
# function startStdMeteo() # constructor function # remove if not needed for implementation
#     error("Not yet implemented")
#     startStdMeteo()
# end

"""
    Ribes_Uva_Crispa()

The start method `Ribes uva-crispa` is based on leaf-out of gooseberry (Janssen
2009). It was developed by the Germany's National Meteorological Service
(Deutscher Wetterdienst, DWD) and is more robust against early starts than
common simple meteorological procedures.

**Not yet implemented!**

## Reference
Janssen, W. (2009)
Definition des Vegetationsanfanges.
*Internal Report, Deutscher Wetterdienst, Abteilung Agrarmeteorologie*.
"""
struct Ribes_Uva_Crispa{} <: VegetationStartMethod
end
# function Ribes_Uva_Crispa() # constructor function # remove if not needed for implementation
#     error("Not yet implemented")
#     Ribes_Uva_Crispa()
# end


# End methods ##############################################################################
"""
    VonWilpert()

The end method `VonWilpert` is based on von Wilpert (1990). It
was originally developed for *Picea abies* in the Black Forest but is
commonly used for all tree species throughout Germany. As usual, the rules
regarding the soilmatrix are neglected in this implementation.


**Not yet implemented!**

# Reference
von Wilpert, K. (1990)
Die Jahrringstruktur von Fichten in Abhängigkeit vom Bodenwasserhaushalt
auf Pseudogley und Parabraunerde: Ein Methodenkonzept zur Erfassung
standortsspezifischer Wasserstreßdispostion.
*Freiburger Bodenkundliche Abhandlungen*.
"""
struct VonWilpert{} <: VegetationEndMethod
end

"""
#' Orthodox are 3 criteria: **short day**, **temperature** and **drought criterion**
#' we consider -as usual- only short day and temperature citerion
#'
#' ## Temperature criterion:
#'  - 7 day moving average of daily mean temperatures
#'      at least 5 consecutive days under 10°C
#'  - if afterwards more than 5 consecutive days 7 day moving average over 10°C
#'     vegetation period gets restarted
#'
#' ## Short day criterion
#' - last day of the vegetation period is DOY 279 (5th of October in leap years)
"""
function get_vegetation_end(dates, Tavg, end_method::VonWilpert)#; Treshold=10, LastDOY=279)

    years = unique(year.(dates))
    # Assumptions:
    # - data.frame 'df' contains month, DOY, Tavg
    # - DOYs at least till LastDOY

    # # Preparation ##########################################################################
    # # moving average with windows size 7 (symetric)
    # df$TmovAvg <- as.numeric(stats::filter(df$Tavg, rep(1/7,7), sides=2))

    # # mark periods ('cold', 'warm') before LastDOY and 'ignore' the rest
    # df$period <- ifelse(df$DOY > LastDOY, 'ignore',
    #                     ifelse(df$TmovAvg < Treshold, 'cold', 'warm'))

    # # determine continous strides of warm/cold by using run length encoding
    # # cold period if stride at least 5
    # # warm period if stride more than 5
    # temp <- rle(df$period)
    # temp$values[temp$lengths < 5] <- 'ignore'
    # temp$values[temp$values == 'warm' & temp$lengths < 6] <- 'ignore'
    # temp$values[is.na(temp$values)] <- 'ignore'
    # df$period <- inverse.rle(temp)

    # LastDOY <- as.integer(LastDOY)

    # # Searching for the end ################################################################
    # # last warm period per year
    # last.warm <- tapply(df$DOY[df$period == 'warm'],
    #                     df$year[df$period == 'warm'],
    #                     FUN=max)
    # last.warm <- data.frame(year=as.integer(row.names(last.warm)), DOY=last.warm)

    # # loop over all years
    # years <- unique(df$year)
    # end <- sapply(years,
    #                 # cold period after last.warm? (yes: min(cold)+4; no: LastDOY)
    #                 FUN=function(x) {
    #                 # cold period after warm period?
    #                 temp <- df[df$year == x & df$period == 'cold', 'DOY']
    #                 temp <- temp[temp > last.warm[last.warm$year == x, 'DOY']]
    #                 if(length(temp) > 0){
    #                     # 5th day of cold period is the end
    #                     min(temp) + 4L
    #                 } else {
    #                     # no colds after last.warm ->  default end
    #                     LastDOY
    #                 }
    #                 }
    # )

    return years
end




"""
    LWF_BROOK90()

The end method `LWF_BROOK90` is -for the sake of convenience- a
reimplementation of the LWF_BROOK90 VBA (version 3.4) variant of "VonWilpert"
(Hammel and Kennel 2001). Their interpretation of von Wilpert (1990) and the
somewhat lower precision of VBA was mimicked.

**Not yet implemented!**

# Reference
Hammel, K. and Kennel, M. (2001)
Charakterisierung und Analyse der Wasserverfügbarkeit und des
Wasserhaushalts von Waldstandorten in Bayern mit dem Simulationsmodell
BROOK90.
*Forstliche Forschungsberichte München*.
"""
struct LWF_BROOK90{} <: VegetationEndMethod
end
# function LWF_BROOK90() # constructor function # remove if not needed for implementation
#     error("Not yet implemented")
#     LWF_BROOK90()
# end

"""
    NuskeAlbert()

The end method `NuskeAlbert` provide a very simple method which is inspired by standard climatological
procedures but employs a 7 day moving average and a 5 °C threshold (cf.
Walther and Linderholm 2006).

**Not yet implemented!**

# Reference
[R package vegperiod](https://github.dev/rnuske/vegperiod)
"""
struct NuskeAlbert{} <: VegetationEndMethod
end
# function NuskeAlbert() # constructor function # remove if not needed for implementation
#     error("Not yet implemented")
#     NuskeAlbert()
# end

"""
    endETCCDI()

The end method `endETCCDI` resp. `endStdMeteo` is a simple threshold based procedure as defined by
the Expert Team on Climate Change Detection and Indices (cf. ETCCDI 2009, Frich et al. 2002,
Zhang et al. 2011) leading to quite late vegetation ends.

**Not yet implemented!**

## Reference
ETCCDI (2009)
Climate Change Indices: Definitions of the 27 core indices.
http://etccdi.pacificclimate.org/list_27_indices.shtml

Frich, P., Alexander, L., Della-Marta, P., Gleason, B., Haylock, M.,
Klein Tank, A. and Peterson, T. (2002)
Observed coherent changes in climatic extremes during the second half of
the twentieth century.
*Climate Research*, **19**, 193--212.
10.3354/cr019193.

Zhang, X., Alexander, L., Hegerl, G. C., Jones, P., Tank, A. K.,
Peterson, T. C., Trewin, B. and Zwiers, F. W. (2011)
Indices for monitoring changes in extremes based on daily temperature and
precipitation data.
*Wiley Interdisciplinary Reviews: Climate Change*, **(6)**, 851--870.
10.1002/wcc.147.
"""
struct endETCCDI{} <: VegetationEndMethod

end
# function endETCCDI() # constructor function # remove if not needed for implementation
#     error("Not yet implemented")
#     endETCCDI()
# end

"""
    endStdMeteo()

The end method `endETCCDI` resp. `endStdMeteo` is a simple threshold based procedure as defined by
the Expert Team on Climate Change Detection and Indices (cf. ETCCDI 2009, Frich et al. 2002,
Zhang et al. 2011) leading to quite late vegetation ends.

**Not yet implemented!**

## Reference
ETCCDI (2009)
Climate Change Indices: Definitions of the 27 core indices.
http://etccdi.pacificclimate.org/list_27_indices.shtml

Frich, P., Alexander, L., Della-Marta, P., Gleason, B., Haylock, M.,
Klein Tank, A. and Peterson, T. (2002)
Observed coherent changes in climatic extremes during the second half of
the twentieth century.
*Climate Research*, **19**, 193--212.
10.3354/cr019193.

Zhang, X., Alexander, L., Hegerl, G. C., Jones, P., Tank, A. K.,
Peterson, T. C., Trewin, B. and Zwiers, F. W. (2011)
Indices for monitoring changes in extremes based on daily temperature and
precipitation data.
*Wiley Interdisciplinary Reviews: Climate Change*, **(6)**, 851--870.
10.1002/wcc.147.
"""
struct endStdMeteo{} <: VegetationEndMethod

end
# function endStdMeteo() # constructor function # remove if not needed for implementation
#     error("Not yet implemented")
#     endStdMeteo()
# end
