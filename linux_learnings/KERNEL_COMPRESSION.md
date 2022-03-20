# CONFIG_KERNEL_GZIP, CONFIG_KERNEL_XZ, CONFIG_KERNEL_LZO and CONFIG_KERNEL_LZMA, CONFIG_KERNEL_LZ4

Ref1: lzo is fastest among gzip,bz2,xz,lzma - https://wiki.postmarketos.org/wiki/Kernel_configuration#CONFIG_KERNEL_GZIP.2C_CONFIG_KERNEL_XZ.2C_CONFIG_KERNEL_LZO_and_CONFIG_KERNEL_LZMA

Ref2: lz4 is even fast than lzo, with almost same compression - https://catchchallenger.first-world.info/wiki/Quick_Benchmark:Gzip_vs_Bzip2_vs_LZMA_vs_XZ_vs_LZ4_vs_LZO

Use lz4

Cons:
1. Compression ke time memory thoda jyada lega... ie. 12 MB for kernel :)
2. Compression ratio lzo ke barabar, jo khud gzip etc se kharab h, to less compression

