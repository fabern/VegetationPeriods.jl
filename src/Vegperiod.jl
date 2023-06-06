module Vegperiod
export vegperiod

function vegperiod(dates, Tavg; start_method = "default", end_method = "default")

    # start_method in ["Menzel",     "StdMeteo", "ETCCDI", "RibesUvaCrispa"]             || error("Unknown start_method: $(start_method)")
    # end_method   in ["vonWilpert", "StdMeteo", "ETCCDI", "LWF-BROOK90", "NuskeAlbert"] || error("Unknown end_method: $(end_method)")
    start_method in ["Menzel"    ] || error("Unknown start_method: $(start_method)")
    end_method   in ["vonWilpert"] || error("Unknown end_method: $(end_method)")

return "nice!"
end


function startDOYs(start_method)
    start_method in ["Menzel"    ] || error("Unknown start_method: $(start_method)")
end

end # module Vegperiod
