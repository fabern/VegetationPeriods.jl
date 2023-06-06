# Test user-facing API:
dates   = Date("2020-01-01"):Day(1):Date("2022-12-31")
Tavg    = rand([-34.9 : 0.1 : 39.9;], length(dates))

@testset "Unsupported methods" begin
    # @test_throws "Unknown start_method" vegperiod(dates, Tavg; start_method = "Menzel",           end_method = "vonWilpert")
    @test_throws "Unknown start_method" vegperiod(dates, Tavg; start_method = "StdMeteo",         end_method = "vonWilpert")
    @test_throws "Unknown start_method" vegperiod(dates, Tavg; start_method = "ETCCDI",           end_method = "vonWilpert")
    @test_throws "Unknown start_method" vegperiod(dates, Tavg; start_method = "Ribes uva-crispa", end_method = "vonWilpert")
    @test_throws "Unknown start_method" vegperiod(dates, Tavg; start_method = "dummy",            end_method = "dummy")
    @test_throws "Unknown start_method" vegperiod(dates, Tavg;                                    end_method = "vonWilpert")
    # @test_throws "Unknown end_method" vegperiod(dates, Tavg; start_method = "Menzel",           end_method = "vonWilpert")
    @test_throws "Unknown end_method" vegperiod(dates, Tavg; start_method = "Menzel",           end_method = "LWF-BROOK90")
    @test_throws "Unknown end_method" vegperiod(dates, Tavg; start_method = "Menzel",           end_method = "NuskeAlbert")
    @test_throws "Unknown end_method" vegperiod(dates, Tavg; start_method = "Menzel",           end_method = "StdMeteo")
    @test_throws "Unknown end_method" vegperiod(dates, Tavg; start_method = "Menzel",           end_method = "ETCCDI")
    @test_throws "Unknown end_method" vegperiod(dates, Tavg; start_method = "Menzel",            end_method = "dummy")
    @test_throws "Unknown end_method" vegperiod(dates, Tavg; start_method = "Menzel")
end

@testset "Menzel: bad species" begin
    @test_throws "Provide a species" vegperiod(dates, Tavg; start_method = "Menzel", end_method = "vonWilpert")
    @test_throws "Unknown species"   vegperiod(dates, Tavg; start_method = "Menzel", end_method = "vonWilpert", species = "dummy")
    @test "nice!" == vegperiod(dates, Tavg; start_method = "Menzel", end_method = "vonWilpert", species = "Larix decidua")
end

@testset "Unequal lenghts" begin
    @test_throws "must be of same length!" vegperiod(dates, Tavg[1:end-1]; start_method = "Menzel", end_method = "vonWilpert", species = "Larix decidua")
end

@testset "Temperature data range" begin
    @test_throws "temperature data exceeds" vegperiod(dates, Tavg .- 70; start_method = "Menzel", end_method = "vonWilpert", species = "Larix decidua")
    @test_throws "temperature data exceeds" vegperiod(dates, Tavg .+ 70; start_method = "Menzel", end_method = "vonWilpert", species = "Larix decidua")
end


# Test internals
