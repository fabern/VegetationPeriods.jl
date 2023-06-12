# see documentation at https://juliadocs.github.io/Documenter.jl/stable/

using Documenter, VegetationPeriods

makedocs(
    modules = [VegetationPeriods],
    format = Documenter.HTML(; prettyurls = get(ENV, "CI", nothing) == "true"),
    authors = "Fabian Bernhard",
    sitename = "VegetationPeriods.jl",
    pages = Any["index.md"]
    # strict = true,
    # clean = true,
    # checkdocs = :exports,
)

# Some setup is needed for documentation deployment, see “Hosting Documentation” and
# deploydocs() in the Documenter manual for more information.
deploydocs(
    repo = "github.com/fabern/VegetationPeriods.jl.git",
    push_preview = true
)
