# Process Isolation

Linux considered very secure, as processes are naturally isolated from each other.
One process can't access resources of other, even if owned by same user; Thus makes hard for viruses to randomly attack resources.

Recent additional security mechanisms:

1. Control Groups (cgroups)
  Allows system administrators to group processes and associate finite resources to each.

2. Containers
  Possible to run isolated Linux systems (containers) on single system **by relying on cgroups**

3. Virtualization
  Entire systems running as isolated guests (virtual machines), on single physical host

