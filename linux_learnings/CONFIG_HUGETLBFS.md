# CONFIG_HUGETLBFS

It is a filesystem backing for hugetlb pages, and is based on ramfs.

ref: https://docs.oracle.com/database/121/UNXAR/appi_vlm.htm#UNXAR401

From reading it, hugetlb seems quite useful when you need it

One such example is given in the article:

> With HugePages, the operating system page table (virtual memory to physical memory mapping) is smaller, because each page table entry is pointing to pages from 2 MB to 256 MB.

> Also, the kernel has fewer pages whose lifecycle must be monitored. For example, if you use HugePages with 64-bit hardware, and **you want to map 256 MB of memory, you may need one page table entry (PTE)**. 
> **If you do not use HugePages**, and you want to map 256 MB of memory, **then you must have 256 MB * 1024 KB/4 KB = 65536 PTEs**.

