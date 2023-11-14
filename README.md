# CéCI Training Days: Introduction to Julia

Julia is a recent (2012) programming language created at the MIT with the aim to provide performance on par with the likes of C and Fortran, with the ease of use of languages like Python and Matlab. The goal of this session is to introduce the key ideas of Julia while giving as many pointers for getting started as possible.

Contents:

- Installing Julia
- Basics of Julia
- Multiple Dispatch
- Installing and managing packages


## Running the examples in this repo

You'll first need to install Julia on your computer. To do that, the easiest way is to use [juliaup](https://github.com/JuliaLang/juliaup) to install the latest version (v1.9.3).

To run the notebooks, you'll at least need a Jupyter installation. The easiest way for that would be to install [VSCode](https://code.visualstudio.com/) (or it's fully open source fork [VSCodium](https://vscodium.com/)), and then install the [Julia Extension](https://www.julia-vscode.org/docs/dev/gettingstarted/) along with the [Jupyter extension](https://github.com/microsoft/vscode-jupyter) (Both of these are available from the Plugin tab in VSCode)

Alternatively, you can just install Jupyter (via `pip`) and install the Julia Jupyter kernel. To do that, launch Julia in a terminal and enter the following line
```
] add IJulia
```
Once the package is installed, you'll be able to select Julia as a kernel in Jupyter notebooks.

## Learning Julia

### Books

- [*Think Julia*](http://www.jdoqocy.com/click-9038105-11290546?url=http%3A%2F%2Fshop.oreilly.com%2Fproduct%2F0636920215707.do%3Fcmp%3Daf-strata-books-video-product_cj_0636920215707_%25zp&cjsku=0636920215707), by Ben Lauwens and Allen Downey, available for free [here](https://benlauwens.github.io/ThinkJulia.jl/latest/book#_copyright)
- [*Julia for Data Analysis*](https://www.manning.com/books/julia-for-data-analysis), by Bogumil Kaminski
- [*Julia as a Second Language*](https://www.manning.com/books/julia-as-a-second-language), by Erik Engheim
- [*Practical Julia: A Hands-On Introduction for Scientific Minds*](https://nostarch.com/practical-julia), by Lee Phillips

### Webpages

- Official Manual https://docs.julialang.org/en/v1/
- https://julialang.org/learning/
- Noteworthy Differences from other languages https://docs.julialang.org/en/v1/manual/noteworthy-differences/

## Packages

- https://juliapackages.com/
- https://github.com/svaksha/Julia.jl

ODE/Dynamical Systems
- [DifferentialEquations](https://docs.sciml.ai/DiffEqDocs/stable/) (The de facto state-of-the-art suite of ODE solvers)
- [ModelingToolkit](https://docs.sciml.ai/ModelingToolkit/stable/) (symbolic modeling of dynamical systems)
- [Catalyst](https://docs.sciml.ai/Catalyst/stable/) (modeling chemical equations)

Optimization
- [JuMP](https://jump.dev/)
- [Optim](https://julianlsolvers.github.io/Optim.jl/)
- [NLOpt](https://github.com/JuliaOpt/NLopt.jl)

Statistics/Probability/Data Analysis
- [JuliaStats](https://juliastats.org/)
- [DataFrames](https://github.com/JuliaData/DataFrames.jl)
- [Distributions](https://juliastats.org/Distributions.jl/stable/)
- [GLM](https://github.com/JuliaStats/GLM.jl) (Linear Models)
- [Turing](https://turinglang.org/dev/) (Bayesian modeling)
- [Tidier](https://tidierorg.github.io/Tidier.jl/stable/) (R's Tidyverse in Julia)

Plotting/Graphics
- [Plots](https://docs.juliaplots.org/latest/)
- [Makie](https://docs.makie.org/stable/)
- [Gadfly](http://gadflyjl.org/stable/)

Misc
- [Unitful](https://painterqubits.github.io/Unitful.jl/stable/) (Working with quantities in various units)
- [Measurements](https://juliaphysics.github.io/Measurements.jl/stable/)

## Details about this repository

This repository is licensed under the Creative Commons CC0 Universal License.

The slides were made with [Typst](https://typst.app/). Demos were made using Jupyter notebooks. Plots shown in the slides were generated in Julia within a [Pluto](https://plutojl.org/) notebook.

All demos use Julia 1.9.3.