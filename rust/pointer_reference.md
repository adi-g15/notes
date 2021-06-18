## Reference Pointers - Point to a resource in memory

pub fn run() {
	// Primitive array
	let arr1 = [1,2,3];
	let arr2 = arr1;	// still arr1 is valid, since this is primitive data type, it will be copied

	println!("Values: {:?}", (arr1,arr2));

	

	// Non-primitive array (vector)
	// with non-primitives, an assignment of a variable to a piece of data, the first variable will no longer hold that value. You'll need to use a reference (&) to 'point' to the resource
	let vec1 = vec![1,2,3];
	let vec2 = vec1;

	println!("Values: {:?}", (vec1, vec2));	// Error: Use of moved value: vec1


	// Taking reference (&), ie. `Borrowing`
	let vec1 = vec![1,2,3];
	let vec2 = &vec1;	// Borrowing vec1

	println!("Values: {:?}",(vec1, vec2));	// Error: cannot move out of 'vec1' because it is borrowed (ie. vec2 = &vec1)

	println!("Values: {:?}",(&vec1, vec2));	// to pass v1, we can use borrow only, since it is borrowed by vec2, we can't move the value now


}
