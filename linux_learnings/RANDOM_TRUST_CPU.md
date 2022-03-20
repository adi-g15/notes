# RANDOM_TRUST_CPU

  Trust the CPU manufacturer to initialize Linux's CRNG

  Can be enabled from kernel command line too: `random.trust_cpu=on`

  Enable this, else usually `systemd-random-seed.service` service takes a LOT of time, jitna yaad hai us hisaab se > 1000 ms, since it waits and tries to create more entropy, there are other ways for eg kuchh hav... etc software hai wo bhi ye time reduce kar dega, but now it takes on ~12 ms.

  > Checking available entropy (should be greater than 1000, ref: archwiki):
  > cat /proc/sys/kernel/random/entropy_avail

   Depends on: ARCH_RANDOM [=y]
   Location:
     Main menu
       -> Device Drivers
         -> Character devices

