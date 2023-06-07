dates   = Date("2020-01-01"):Day(1):Date("2022-12-31")
Tavg    = rand([-34.9 : 0.1 : 39.9;], length(dates))


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
end

@testset "vegetation_end" begin
    # TODO
end
