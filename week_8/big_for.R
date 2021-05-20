# Counting n ----
n <- 0
for (i in 1:1e7) {
  n <- n + i
}
print(n)

# Counting m ----
m <- 0
for (i in 1:1e7) {
  m <- m + 2 * i
}
print(m)
