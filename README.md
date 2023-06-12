# VegetationPeriods.jl: Determine Thermal Vegetation Periods

<!-- Tidyverse lifecycle badges, see https://www.tidyverse.org/lifecycle/ Uncomment or delete as needed. -->
![lifecycle](https://img.shields.io/badge/lifecycle-stable-green.svg) [![build](https://github.com/fabern/VegetationPeriods.jl/workflows/CI/badge.svg)](https://github.com/fabern/VegetationPeriods.jl/actions?query=workflow%3ACI)[![codecov.io](https://codecov.io/github/fabern/VegetationPeriods.jl/badge.svg?token=87V75HVNO0)](https://codecov.io/github/fabern/VegetationPeriods.jl)
<!-- Documentation -- uncomment or delete as needed -->
<!--
[![Documentation](https://img.shields.io/badge/docs-stable-blue.svg)](https://fabern.github.io/VegetationPeriods.jl/stable)
[![Documentation](https://img.shields.io/badge/docs-dev-blue.svg)](https://fabern.github.io/VegetationPeriods.jl/dev)
-->

Julia impelementation of the R pkg `vegperiod` by Robert Nuske: https://github.com/rnuske/vegperiod.

From their current README:
> The vegetation period, or growing season, is the period of the year when the weather conditions are sufficient for plants to grow. This package provides methods to calculate climatological or thermal growing seasons solely based on daily mean temperatures and the day of the year (DOY). Because of their simplicity, they are commonly used in plant growth models and climate change impact assessments.

Please refer to https://github.com/rnuske/vegperiod for further information about the methods.

## Installation
Currently installation of the package is done in Julia with:
```julia
julia> import Pkg
julia> Pkg.add(path="https://github.com/fabern/VegetationPeriods.jl.git")
```
The package will be registered with the [Julia Package Registry](https://github.com/JuliaRegistries/General) at a later point in time.

## Attributions and License
The R package was created by [Robert Nuske](https://orcid.org/0000-0001-9773-2061).
This Julia package was written by [Fabian Bernhard](https://orcid.org/0000-0003-0338-0961).

Both are licensed under GPLv3.
