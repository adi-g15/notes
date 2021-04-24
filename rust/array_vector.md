## Array

Fixed list where elements are of same data type

**NOTE** - *ARRAYS IS A "PRIMITIVE" DATA TYPE, SO CAN BE VALUE ASSIGNED, AND PREVIOUS VALUE WON'T BE INVALIDATED (since it was a value, not a reference, like in vectors)*

```rs
let arr: [u32; 5] = [1,2,3,4,5];
```

### Debugging/Printing array values

> Use debug trait

```rs
println!("{:?}", arr);
```

### Length

```rs
println("Length: {}", arr.len());
```

### Memory Occupied

**For this we use `std::mem` module, which has the `std::mem::size_of_val()` function which takes a reference to the type**

```rs
println("Space consumed by arr: {}", std::mem::size_of_val( &arr ));    // will be "4 * arr.len()"
```

### Slices

> We can take the whole array or a part of it

```rs
let full_slice: &[i32] = &arr;
println!("Slice: {:?}", full_slice);

let first_two: &[i32] = &arr[0..2]; // [0,2)
println!("Slice: {:?}", first_two);
```

## Vectors

Resizable arrays

> All the above operations on arrys supported by vectors too

> On my system, `Size of Vector = 24` (this is static storage only, APART from capacity)

```rs
// .push
// .iter
// .iter_mut
```
