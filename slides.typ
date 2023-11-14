#import "@preview/polylux:0.3.1": *
#import themes.simple: *
//#import "theme-unamur.typ": *

#import "@preview/colorful-boxes:1.2.0": *
#import "@preview/codetastic:0.2.2": qrcode

//#show: unamur-theme.with()
#show: simple-theme.with(
    //footer: [#logic.logical-slide.display()]
    )

#set text(size: 20pt)
#show link: set text(blue)
#set text(font: "Comfortaa")
#show heading: set text(font: "Comfortaa", bottom-edge: "baseline")
#show raw: set text(font: "JuliaMono")
#set raw(align: left)
#show emph: set text(font: "Carlito")

#let note(dy: 1.5em, textsize: 0.7em, body) = {
    set text(size: textsize)
    place(bottom + left,
    dy: dy, body)
}

#title-slide[
    = Introduction to Julia
    == Cédric Simal
    #link("cedric.simal@unamur.be")
    == CéCI Training Sessions
    14/11/2023

]

#centered-slide[
== Science Anniversaries of today
#side-by-side[
    #image("images/appolo-12.jpg", height: 70%)
    Apollo 12 Launch (1969)
][
    #image("images/baekeland.jpg", height: 70%)
    Birth of Leo Baekeland (1863)
]

#note[image source: Wikipedia]
]

#slide[
== Outline


+ Installing Julia
+ Elevator pitch (while you're installing)
+ The Julia REPL
+ Basics of Julia
+ Multiple Dispatch
+ Package Management

]

#slide[
== Installing Julia (via Juliaup)
#side-by-side[
#text(size: 0.8em, [https://github.com/JuliaLang/juliaup])

Windows
```
winget install julia -s msstore
```
Mac/Linux
```
curl -fsSL https://install.julialang.org | sh
```

Then
```
juliaup update
```
][
#set align(center)
Follow along!

#qrcode("https://github.com/csimal/CeCI-Intro-Julia")

#text(size:0.8em)[https://github.com/csimal/CeCI-Intro-Julia]
]
]

#slide[
== Book Recommendations
#side-by-side[
#image("images/think-julia.jpeg", height: 60%)
][
#image("images/julia-for-data-analysis.jpg", height: 60%)
][
#image("images/julia-second-language.jpg", height: 60%)
][
#image("images/practical-julia.jpg", height: 60%)
]

#note[https://benlauwens.github.io/ThinkJulia.jl/latest/book]
]

#slide[
= Modern Problems in Scientific Computing
== The two languages problem
#align(center)[
    #image("images/two-languages-problem.png", height: 70%)
]
]

#slide[
== The rise of parallel computing
#align(center)[
#image("images/cpu-languages.svg", height: 80%)
]
#note[data: https://github.com/karlrupp/microprocessor-trend-data]
]

#slide[
= Meet Julia
== A short history
#align(center)[
    #image("images/timeline.png", height: 65%)
]
#note(textsize: 0.6em)[https://julialang.org/blog/2012/02/why-we-created-julia/

https://www.hpcwire.com/off-the-wire/julia-joins-petaflop-club/]
]

#slide[
== Julia is fast
#set align(center)
#image("images/benchmarks.svg", height: 83%)

#note[https://julialang.org/benchmarks/]
]

#slide[
== Julia is fast (2)
#set align(center)
#image("images/ode-benchmark.png", height: 80%)

#note[https://benchmarks.sciml.ai/stable/MultiLanguage/ode_wrapper_packages/]
]

#slide[
== Why you might want to use Julia

- Open Source (MIT license)
    - Free as in Free Beer _and_ Free Speech
    - Faster development than proprietary languages
- Made for numerical computing
- Amazing Interop with C/C++, Fortran, Python, Matlab...
- Unicode
    - Code looks like math
- Secretly a LISP
]

#slide[
== Why you might *NOT* want to use Julia
#align(center)[
#stickybox(rotation: 1deg, width: 15cm)[
// Architext
#block(inset: 0.7em)[
#text(size: 0.9em, font: "Handlee")[
If you want to evangelize a tool or process or technology, you should be able to answer two questions:
 + What negative thing do you have to deal with?
 + What positive thing do you have to give up?
]]]
]

My personal takes for Julia:

+ Time to first X; Poorly documented/Undocumented features.
+ No formal Interfaces/Traits/Typeclasses. Types don't help with correctness.

#note[https://hillelwayne.com/hate-your-tools/]
]

#slide[
== Why you might *NOT* want to use Julia

- Open Source
    - Documentation can be lackluster
    - Projects with only one maintainer
- Time to first X
    - Parts of your program have to be recompiled on startup
- Error messages are not beginner-friendly
- Correctness bugs
- Tiny compared to Python
- Array indices start at 1

#note()[More criticism: https://yuri.is/not-julia/]
]

#focus-slide[
    = The Julia REPL
]

#focus-slide[
    = Basics of Julia
]

#slide[
== Variables, comments and statements
#side-by-side[
Variable declaration
```jl
foo = 1
```
Multiple declarations
```jl
a, b, c = 1, 2, 3 
# a = 1; b = 2; c = 3 
```
Multiline comment
```jl
#= This comment
spans multiple 
lines
=#
```
][
By default, one statement per line
```jl
a = 1
a += 1 # a = a + 1
a *= 2 # a = a * 2

# compact version
a = 1; a += 1; a *= 2

# block version
begin
    a = 1
    a += 1
    a *= 2
end
```   
]
]

#slide[
== Elementary Types
//#set text(size: 0.9em)
#side-by-side[
Integers
```jl
a = 1
```
Floating point numbers (double)
```jl
b = 0.2
```
Booleans
```jl
e = true; f = false
```][
Strings and characters
```jl
c = 'c'
d = "Hello, world\n" # NB C-style character literals work
```
Arrays, tuples and Dicts
```jl
x = [1, 2, 3]
y = ("Waffle", 2)
z = Dict(
    "Frites" => 2.0,
    "Fricandelle" => 1.5,
    "Sauce Andalouse" => 0.3,
)
```
]
]

#slide[
== Conditionals
//#set text(size: 0.9em)
#side-by-side[
```jl
# get a random number between -30 and 150
water_temperature = rand(-30:150) 
if water_temperature < 0
    print("Ice")
elseif water_temperature < 100
    print("Liquid Water")
else
    print("Steam")
end
```
][
Note that an if block is an expression that returns a value:
```jl
age = rand(1:40)
status = if age < 18
    "minor"
else
    "adult"
end
```
Ternary operator
```jl
status = age < 18 ? "minor" : "adult"
```
]
]

#slide[
== Loops
#side-by-side[
Python style for-loops with iterators
```jl
k = 0
for i in 1:10
    k += i
end
```

```jl
n = 10
while n != 1
    n = iseven(n) ? div(n,2) : 3*n+1
end
```
][
Special Syntax for nested for loops
```jl
for i in 1:5
    for j in 1:3
        print(i+j)
    end
end
# This can be rewritten as
for i in 1:5, j in 1:3
    print(i+j)
end
```
]
]

#slide[
== Arrays

```jl
# a 1 dimensional vector with 10 elements of type 'double'
a = Vector{Float64}(undef, 10)
# equivalent to previous line
b = Array{Float64,1}(undef, 10)
# A 2 dimensional array of integers with 3 rows and 4 columns
c = Array{Int,2}(undef, 3,4)
d = Array{Int,2}(undef, (3,4))
```

Special constructors for arrays of zeroes/ones/arbitrary value
```jl
e = zeros(3,4)
f = ones(3)
g = fill("Hello", 4)
```

]

#slide[
== Array Constructors
#side-by-side[
Explicit enumeration
```jl
a = [1,2,3,4] # 1D array (column vector)
b = [1 2 3 4] # 1 x 4 matrix (row vector)
c = [1 2; 3 4; 5 6] # 3 x 2 matrix
d = [1; 2;; 3; 4;;; 5; 6;; 7; 8] # 2 x 2 x 2 3D array
```

Ranges
```jl
i = 1:10 # integers from 1 to 10
x = 0.0:0.01:1.0 # from 0.0 to 1.0 by steps of 0.1
y = LinRange(0.0,1.0,100)
```
][
Array Comprehensions
```jl
# Apply arbitrary function to a collection
a = [i^2 for i in 1:10]
# Use multiple indices to generate higher dimensional arrays
b = [i+j for i in 1:5, j in 1:5]
# Filter elements using a condition
c = [i/(i^2) for i in 1:10 if iseven(i)]
# special syntax for functions taking a collection
p = 4 * sum((-1)^k / (2k+1) for k in 0:10000)
```
]
]

#slide[
== Array indexing
#side-by-side[
```jl
# default arrays start at 1
a[1]
# use an array of indices
a[[1,3,5]]
# ranges work too
a[1:5]
a[begin] # first element
a[end] # last element
```
Iterate over an arbitrary array
```jl
for i in eachindex(a)
    print(a[i])
end
```
][
Array slicing
```jl
b = rand(3,4) # 3 x 4 matrix of random numbers
b[1,:] # first row of b
b[:,2] # second column of b
```
Iterate over array dimension
```jl
for j in axes(b,2)
    print(b[:,j])
end
```
]
]

#slide[
== Broadcasting
#set text(size: 0.9em)
#side-by-side[
    Function calls work as usual
```jl
cos(π/2) # NB. use "\pi<TAB>" for unicode π
```
Special syntax for "vectorizing" function calls
```jl
xs = LinRange(0.0,2π,100)
cos.(xs)
# equivalent to
[cos(x) for x in xs]
# It also applies to infix operators
xs .* cos.(xs)
```
][
Modifying arrays
```jl
a = zeros(5)
a .= [1,2,3,4,5] # NB. without the dot, this would create a new array
a .+= 1.0
a .+= [6,7,8,9,10]
```
Multiple broadcasted calls
```jl
a .= a.^3 .- a.^2 .+ a .- 1
# equivalent to
for i in eachindex(a)
    a[i] = a[i]^3 - a[i]^2 + a[i] - 1
end
# short-hand
@. a = a^3 - a^2 + a - 1
```
]
]

#slide[
== Functions
#side-by-side[
```jl
function collatz(n)
    if iseven(n)
        return div(n,2)
    else
        return 3n+1
    end
end
# More compact version
function collatz(n)
    return iseven(n) ? div(n,2) : 3n+1
end
# implicit return
function collatz(n)
    iseven(n) ? div(n,2) : 3n+1
end
```
][
Inline definition
```jl
square(x) = x^2
```
Lambda expressions/Anonymous functions
```jl
square = x -> x^2
square = function(x)
    x^2
end
```
]]

#slide[
== Default values and keyword arguments
```jl
function say_hello(x = "World"; hello_str="Hello", end_str="!")
    # NB. '*' concatenates strings
    println(hello_str * ", " * x * end_str)
end
```
```
julia> say_hello()
Hello, World!

julia> say_hello("Alice")
Hello, Alice!

julia> say_hello("Alice", hello_str="Bonjour", end_str="?")
Bonjour, Alice?
```
]

#focus-slide[
    = The Type System
]

#slide[
== Elementary Types
#set raw(align: left)
#side-by-side[
Type annotations
```jl
a::Int = 1
b::Float64 = 0.2
c::Vector{Int} = [1,2,3]
```
Numeric types

- Integers: ```jl Int``` (```jl Int64```), ```jl Int32```, ...
- Unsigned Ints: ```jl UInt64```, ```jl UInt32```, ...
- Floats: ```jl Float64```, ```jl Float32```, ...
- Complex Numbers: ```jl ComplexF64```, ```jl Complex{Float64}```, ...
][
Collections with generic element types
- N-dimensional Array of eltype `T`: ```jl 
Array{T,N}
```
- Dictionary with keys of type `K` and values of type `V`: ```jl 
Dict{K,V}
```
]
]

#slide[
== Creating new types
#side-by-side[
```jl
struct Student
    name::String
    age::Int
    section::String
    year::Int
end
```

Default constructor
```jl
alice = Student("Alice", 22, "Chemistry", 4)
# accessing fields
alice.section
```][
Mutable structs
```jl
mutable struct Lightbulb
    age::Int
    wattage::Float64
    turned_on::Bool
end
```
Type parameters
```jl
struct Point2D{T}
    x::T
    y::T
end
```
]
]

#slide[
== Subtyping
#grid(
    columns: (35%, 65%)
)[
Subtype relation
```jl 
Int <: Integer
```

Defining a type as a subtype
```jl
abstract type Animal end
abstract type Mammal <: Animal end
struct Tiger <: Mammal end
```
][
#set align(right)
#image("images/type-tree-annotated.png", height: 80%)
]]

#slide[
== First-Class Citizens

#align(center)[
#stickybox(rotation: 1deg, width: 15cm)[
// Architext
#block(inset: 0.7em)[
#text(size: 1em, font: "Handlee")[
In a given programming language, first-class citizens are objects that
+ can be used as arguments of functions
+ can be returned by functions
+ can be assigned to variables
+ can be tested for equality
]]]
]



In Julia, the following objects are first-class citizens

- Functions ($=>$ Functional Programming)
- Types (via the `Type{T}` type)
- Julia expressions ($=>$ Metaprograming)
]

#slide[
== Multiple Dispatch
#side-by-side[
Functions can be defined with specific input types
```jl
function collatz(n::Int)
    iseven(n) ? div(n,2) : 3n+1
end
```
Optional return type
```jl
function collatz(n::Int)::Int
    iseven(n) ? div(n,2) : 3n+1
end
```
][
Multiple definitions with different types (Methods)
```jl
foo(n::Int) = "$n is an Int"
foo(x::Float64) = "$x is a Float"
foo(s::String) = "$s is a String"
```
NB. a function is just a name with multiple methods!
]
]



#slide[
== Multiple Dispatch (2)
#side-by-side[
Let's model chemical reactions
```jl
abstract type Chemical end
struct H2 <: Chemical
struct H2O <: Chemical end
struct O2 <: Chemical end
struct SO3 <: Chemical end
...
```
][
- `H2` + `O2` $->$ `H2O` (+ explosion)
- `H2O` + `SO3` $->$ `H2SO4`
- otherwise nothing happens
]
]

#slide[
== Multiple Dispatch (3)
#side-by-side[
Don't do this!
```jl
function mix(x,y)
    if (x isa H2 && y isa O2)
        return "Boom!"
    elseif (x isa H2O && y isa SO3)
        return "Sulfuric Acid!"
    else
        return "Nothing happens."
    end
end
```
][
Use multiple dispatch
```jl
mix(::H2, ::O2) = "Boom!"
mix(::O2, ::H2) = "Boom!"
mix(::H2O, ::SO3) = "Sulfuric Acid!"
mix(::SO3, ::H2O) = "Sulfuric Acid!"
mix(::Chemical, ::Chemical) = "Nothing Happens"
```
]
#note[For another example: https://www.moll.dev/projects/effective-multi-dispatch/]
]

#slide[
== Multiple Dispatch: Dual Numbers
#side-by-side[
```jl
struct Dual <: Number
    x::Float64
    y::Float64
end

convert(::Type{Dual}, x::Real) = Dual(x, zero(x))
promote_rule(
    ::Type{Dual}, 
    ::Type{<:Number}) = Dual
show(io::IO, d::Dual) = print(io, d.x, " + ", d.y," ϵ")
```
][
    Arithmetic operations
```jl
+(a::Dual, b::Dual) = Dual(a.x + b.x, a.y + b.y)
-(a::Dual, b::Dual) = Dual(a.x - b.x, a.y - b.y)
*(a::Dual, b::Dual) = Dual(a.x * b.x, a.y*b.x + a.x*b.y)
/(a::Dual, b::Dual) = Dual(a.x/b.x, (a.y*b.x - a.x*b.y)/(b.x^2))


```
]
]

#focus-slide[
= Package Management
]

#slide[
== Noteworthy packages (for science)

#side-by-side[
ODEs/Dynamical Systems
    - `DifferentialEquations.jl`
    - `ModelingToolkit.jl`
    - `Catalyst.jl` (chemical equations)
Optimization
    - `JuMP`
    - `Optim.jl`
Misc
    - `Unitful.jl`
    - `Measurements.jl`
][
Statistics/Probability
    - `Distributions.jl`
    - `Statistics.jl`
    - `GLM.jl` (Linear Regression)
    - `Turing.jl`, `Gen.jl`, `Stan.jl` (Bayesian models)
    - `Tidier.jl` (Tidyverse in Julia)
Plotting
    - `Plots.jl`
    - `Makie.jl`
    - `Gadfly.jl`
]
]