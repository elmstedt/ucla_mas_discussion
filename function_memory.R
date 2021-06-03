# Using local() to make functions with a memory
f <- local({
  # persistent variables
  x <- 0
  # function
  function(v) {
    if (missing(v)) {
      message("v is missing.")
    } else {
      message("v is: ", v)
      message("x is: ", x)
      message("adding v = ", v, " to x = ", x)
      x <<- v + x
    }
    message("x is: ", x)
    x
  }
})

for (i in 1:10) {
  f(i)
}
total <- f()
total
f(-total)
f()
