# struct - Used to create custom data types

```rs
// 1. Traditional struct
struct Color {
	red: u8,
	green: u8,
	blue: u8,
}



// 2. Tuple Struct
struct Color(u8,u8,u8);			// accessed using c.0, c.1, c.2


// 3. With function
struct Person {
	first_name: String,
	last_name: String
}

impl Person {
	fn new(first: &str, last: &str) -> Person {
		Person {
			first_name: first.to_string(),
			last_name: last.to_string()
		}
	}

	// getters, use '&self' since no modifications required
	fn full_name(&self) -> String {
		format!("{} {}", self.first_name, self.last_name);
	}

	// for modifiers, use '&mut self'
	fn set_last_name(&mut self, last: &str) {
		self.last_name = last.to_string();
	}
}




```
