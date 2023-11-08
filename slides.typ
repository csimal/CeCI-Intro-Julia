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
#show raw: set align(center)
#show emph: set text(font: "Carlito")


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

#place(bottom + left, 
dy: 1em,
text(size: 0.7em, [image source: Wikipedia]))
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
Windows
```
winget install julia -s msstore
```
Mac/Linux
```
curl -fsSL https://install.julialang.org | sh
```
][

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
#place(bottom + left,
dy: 1em,
text(size: 0.7em, [https://benlauwens.github.io/ThinkJulia.jl/latest/book])
)
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
#place(bottom + left, 
dy: 1em,
text(size: 0.7em, [data: https://github.com/karlrupp/microprocessor-trend-data]))
]

#slide[
= Meet Julia
== A short history

]

#slide[
== Julia is fast
#set align(center)
#image("images/benchmarks.svg", height: 83%)

#place(bottom + left, 
dy: 1em,
text(size: 0.7em, [https://julialang.org/benchmarks/]))
]

#slide[
== Julia is fast (2)
#set align(center)
#image("images/ode-benchmark.png", height: 80%)

#place(bottom + left, 
dy: 1em,
text(size: 0.7em, [https://benchmarks.sciml.ai/stable/MultiLanguage/ode_wrapper_packages/]))
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
#text(size: 0.9em, font: "Handlee")[
If you want to evangelize a tool or process or technology, you should be able to answer two questions:
 + What negative thing do you have to deal with?
 + What positive thing do you have to give up?#footnote([https://hillelwayne.com/hate-your-tools/])
]]]

My personal takes for Julia:

+ Time to first X; Poorly documented/Undocumented features.
+ No formal Interfaces/Traits/Typeclasses. Types don't help with correctness.
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

]

#focus-slide[
    = Basics of Julia
]

#slide[
== Variables and comments

Variable declaration: 
```jl
foo = 1
```
Multiple declarations:
```jl
a, b, c = 1, 2, 3 # a = 1; b = 2; c = 3 
```
Multiline comment:
```jl
#= This comment
spans multiple 
lines
=#
```

]

#slide[
== Expressions

```jl
a = 1; a += 1; a *= 2
# equivalent to
a = 1
a += 1 # a = a + 1
a *= 2 # a = a * 2

begin
    a = 1
    a += 1
    a *= 2
end
```

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
    "Sauce Andalouse" => 0.3
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
Note that an if bloc is an expression that returns a value:
```jl
age = rand(1:40)
status = if age < 18
    "minor"
else
    "adult"
end
```
Ternary operator:
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
for k in 1:10
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

Special constructors for arrays of zeroes/ones/arbitary value
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
    print(hello_str * ", " * x * end_str)
end
```
```
julia> say_hello()
Hello, World!

julia> say_hello("Alice")
Hello, Alice!

julia> say_hello("Alice", hello_str="Bonjour", end_str="?")
```
]

#focus-slide[
    = The Type System
]

