# Day 1

### Keep calm

* Two states of every programmer
* "Python is the worst programming language but it's better than all the others." -- Winston Churchill
* "An expert is someone who's already made all the mistakes."
* Integer division causes anguish
* Programming is unnatural

### Python

* How to use
  - Interpreter vs notebook, terminal (I/O) vs shell (brains)
  - ipython is better than regular old python
  - append a "3" to everything, apologize for necessity
  - the great thesis distraction project (matplotlib, ipython, sympy)
  - pip installs things
* Basic things
  - defining variables, arithmetic operations
  - defining strings, printing
  - conditionals
* Collections
  - lists
  - tuples
  - dictionaries
* Iteration over...
  - a range
  - a list
  - a dictionary
* Functions
  - how to define
  - positional vs. keyword arguments
  - returning multiple values
* Packages
  - how to import
  - how to get help
* NumPy
  - making arrays
  - algebra on arrays
* matplotlib

### Finite element analysis

* A bit about weak forms -- PDEs are a lie, only conservation laws matter
* Solutions of differential equations have infinitely many degrees of freedom
* Galerkin's method: pick a set of basis functions to represent the solution
* What basis functions to use?
  - spectral
  - local polynomial
* How to determine the coefficients?
  - collocation
  - weighted residual
* Finite element method = Galerkin with local polynomials + weighted residual
* Example by hand for the Poisson problem
* Why FEA took off in engineering so much

### Firedrake

* The DSL and why it's great
* Making meshes
* Defining and interpolating functions, plotting
* Make a 1-triangle mesh and show a bunch of finite element basis functions
