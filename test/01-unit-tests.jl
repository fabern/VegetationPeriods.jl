dates   = Date("2020-01-01"):Day(1):Date("2022-12-31")
Tavg    = rand([-34.9 : 0.1 : 39.9;], length(dates))
include("data_goe.jl") # defines dates_goe and Tavg_goe (3 years)

# using Plots; plot(dates_goe[1:3*365], Tavg_goe[1:3*365])


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
    @test                  VonWilpert(Threshold_degC = 10,  LastDOY = 279) isa VegetationEndMethod
    @test                  VonWilpert(Threshold_degC = 10., LastDOY = 279) isa VegetationEndMethod
    @test_throws TypeError VonWilpert(Threshold_degC = "10.0", LastDOY = 279)


    # Test values
    @test vw.Threshold_degC == 10.0
    @test vw.LastDOY == 279
    vw2 = VonWilpert(Threshold_degC = 8., LastDOY = 266)
    @test vw2.Threshold_degC == 8.0
    @test vw2.LastDOY == 266

    # Test function values
    # ==> see @testset "vegetation_start" and "vegetation_end"
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
    # Test only Menzel and VonWilpert here. The rest is in testsets "vegetation_start" and "vegetation_end":
    res = vegperiod(dates_goe, Tavg_goe,
                    Menzel("Picea abies (frueh)", est_prev=3),
                    VonWilpert())
    @test res.year == [2001, 2002, 2003]
    @test res.startdate == Date.(["2001-04-29","2002-05-07","2003-05-05"])
    @test res.startDOY == [119, 127, 125]
    @test res.enddate == Date.(["2001-10-01","2002-10-06","2003-10-06"])
    @test res.endDOY == [274, 279, 279]

end





# 2) Test internals ########################################################################
###################################################################
@testset "vegetation_start" begin
    # Menzel: =========
    res1a,res1b = VegetationPeriods.get_vegetation_start(dates_goe, Tavg_goe, Menzel("Picea abies (frueh)", est_prev=3), return_intermediate_results = true)
    res2a,res2b = VegetationPeriods.get_vegetation_start(dates_goe, Tavg_goe, Menzel("Picea abies (frueh)", est_prev=2), return_intermediate_results = true)
    res3a,res3b = VegetationPeriods.get_vegetation_start(dates_goe, Tavg_goe, Menzel("Picea abies (frueh)", est_prev=0), return_intermediate_results = true)
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
    # VonWilpert: =========
    res1 = VegetationPeriods.get_vegetation_end(dates_goe, Tavg_goe, VonWilpert())
    @test res1.year == 2001:2003 # 2001:2010
    # print(IOContext(stdout, :compact=>false), res1.enddate)
    @test res1.enddate == Date.(["2001-10-01", "2002-10-06", "2003-10-06"])#, "2004-10-05", "2005-10-02", "2006-09-28", "2007-10-06", "2008-10-05", "2009-10-06", "2010-10-06"])
    # print(IOContext(stdout, :compact=>false), res1.endDOY)
    @test res1.endDOY == [274, 279, 279] #, 279, 275, 271, 279, 279, 279, 279]
end
