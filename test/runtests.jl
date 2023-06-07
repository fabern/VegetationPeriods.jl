using Vegperiod
using Dates
using Test
using Random
using Printf
using Logging

import DataFrames: groupby, subset

# Note the git hash-string and repository status (can be optionally used in filenames for plots etc.)
git_status_string = "__$(today())git+"*chomp(Base.read(`git rev-parse --short HEAD`, String))*
            ifelse(length(Base.read(`git status --porcelain`, String))==0, "+gitclean","+gitdirty")*
            "__"

# A macro for timing that also prints out the git commit hash:
macro githash_time(variable)
    quote
        #model = replace(chomp(Base.read(`sysctl hw.model`, String)), "hw.model: " => "")
        model = "amberMBP"
        hash = chomp(Base.read(`git rev-parse --short HEAD`, String))
        print(model*"-git-"*hash*":")
        @time $(esc(variable))
    end
end
# Alternatively: think about measuring performance along the lines discussed in
# https://discourse.julialang.org/t/benchmarking-tests-to-ensure-prs-dont-introduce-regressions/8630/6
# or then https://github.com/maxbennedich/julia-regression-analysis or ...)

Random.seed!(1234)
include("01-unit-tests.jl")

include("02-integration-tests.jl")

# include("03-regression-tests.jl")


## NOTE add JET to the test environment, then uncomment
# using JET
# @testset "static analysis with JET.jl" begin
#     @test isempty(JET.get_reports(report_package(Vegperiod, target_modules=(Vegperiod,))))
# end