## Functions and Closures

Functions you know

### Closures

```rust
let n3 = 40;

let closure = |n1: i32, n2: i32| n1+n2+n3;  // using outside variable too

println!("Sum: {}", closure(4,5));  // 49
```
