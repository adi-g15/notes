## String

* Primitive str - Fixed length immutable string in memory

* String - Growable heap allocated string

```rs
    let h = "Immutable str";

    let name = String::from("Aditya");  // gives the heap allocated string

    let buffer = String::with_capacity(10);

    assert_eq!(10, buffer.capacity());

    let msg = "Namaste World";

    msg.contains("Namaste");
    msg.is_empty();

    println!( "{}", msg.replace("World", "Vishwa") ); // returns a new string
    // Namaste Vishwa

    println!(msg);  // "Namaste World"

    // splitting by whitespace (to get words)
    for word in msg.split_whitespace() {
        println!("{}", word);
    }

```
