### Types

## Primitive

u8, i8, *16, *32, *64,
f32, f64
bool
char

### Maximum representable value

```rs
println!("Max i32: {}", std::i32::MAX);
println!("Max i64: {}", std::i64::MAX);
```

### Unicode chars

```rs
let a1 = 'a';

let face = '\u{1F600}'; // 1F600 is code for 😅

println!("{:?}", (a1, face));
```
