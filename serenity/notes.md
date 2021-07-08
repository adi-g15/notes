# Notes

Building the toolchain took 56 minutes on a 2 core machine, with stdout directed to /dev/null, and... there was no warning or errors when compiling binutils and gcc... great !

While Reading the CMakeLists also found that it can be built for 64 bit, by setting `SERENITY_ARCH`
Only problem with this 64 bit build is, that there is #FIXME note there, disabling TLS support, and mentioned is that implement TLS support, so maybe in future when they implement it, or maybe you yourselves contribute a part of it Adi ;D.

Also serenity uses C++20 and ninja... quite modern huh :D

### Using native tools instead of the cross compiled ones

1 ghanta gcc aur binutils ka time bacha sakte hai agar latest gcc binutils ho, aur serenity ko bhi 64 bit me compile kare

See after line 161 in CMakeLists, it contains this ->

```cmakelists
set(CMAKE_C_COMPILER ${TOOLCHAIN_PREFIX}gcc)
#... similar for other tools
```

Till now read till this

