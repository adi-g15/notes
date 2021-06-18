## User and Group IDs

The OS identifies the user who starts a process by RUID (Real User ID) assigned to the user.
The user who determines the access rights for the users is identified by the EUIF (Effective UID)

Same for groups, since users can be categorized into various groups.
Each group identified by RGID (Real Group ID). And access rights of group determined by EGID (Effective Group ID).

> EUID may or may not be same as RUID

> Each user can be a member of multiple groups
