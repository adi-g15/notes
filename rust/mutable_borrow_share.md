Ways to borrow mutably:

Way 1 -
In main.rs
	let mut matches = [/*...*/];
	ipl::func(&mut matches);

In ipl.rs
	fn func(matches: &mut Vec<...>) {}

--------------------------------------
Way 2 -
In main.rs
	let matches = [/*...*/];
	ipl::func(matches);

In ipl.rs
	fn func(mut matches: Vec<...>) {}
