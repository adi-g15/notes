## Formatting output

### Basic

```rust
println!("Name is {}", "Adi");
```

### Positional Arguments

> Helpful when print some variable multiple times

```rust
println!("{0} likes {1} and {0} is from {2}", "Adi", "Computers", "Delhi");
```

### Named Arguments

> Satisfies same needs as of Positional Arguments

```rust
println!("{name} likes {activity} and is from {city}", name = "Adi", activity = "Computers", city = "Delhi");
```

### Placeholders for Traits

> There are a lot

```rust
println!("Binary: {:b}, Hex: {:x}, Octal: {:o}", 10, 10, 10);
```

### Placeholder for debug trait

```rs
println!("{:?}", (3, true, "Namaste"));
```
