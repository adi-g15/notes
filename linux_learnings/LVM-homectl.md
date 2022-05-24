## To use LVM storage backend for home of a user created with homectl

These modules required:

> diff before after

```diff
3a4
> asn1_encoder
14a16
> cbc
25a28,29
> dm_crypt
> dm_mod
28a33
> encrypted_keys
54a60
> loop
97a104
> tee
101a109
> trusted
```

Mainly...

* `CONFIG_BLK_DEV_LOOP` (Loopback device support)
* `CONFIG_DM_CRYPT` (Crypt target support)
* `CONFIG_BLK_DEV_DM` (Device mapper support)
* `CONFIG_TRUSTED_KEYS`, `CONFIG_ENCRYPTED_KEYS` etc.
* (maybe even `CONFIG_TEE`, ie. Trusted Execution Environment support)

