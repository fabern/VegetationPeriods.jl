# Vegperiod.jl: Determine Thermal Vegetation Periods

Julia impelementation of the R pkg `vegperiod` by Robert Nuske: https://github.dev/rnuske/vegperiod.

From their current README:
> The vegetation period, or growing season, is the period of the year when the weather conditions are sufficient for plants to grow. This package provides methods to calculate climatological or thermal growing seasons solely based on daily mean temperatures and the day of the year (DOY). Because of their simplicity, they are commonly used in plant growth models and climate change impact assessments.

Please refer to https://github.dev/rnuske/vegperiod for further information about the method.

## Installation
Currently installation of the package is done in Julia with:
```julia
julia> import Pkg
julia> Pkg.add(path="https://github.com/fabern/Vegperiod.jl.git")
```
The package will be registered with the [Julia Package Registry](https://github.com/JuliaRegistries/General) at a later point in time.

## Attributions and License
The R package was created by Robert Nuske. This Julia implementation is a [Fabian Bernhard](https://orcid.org/0000-0003-0338-0961)

Both are licensed under GPLv3.
