# One node blockchain, with docker

Uses `sawtooth-default.yml` docker compose configuration file.

The file is included at end

## Observations

In `services:`, there are these tp (transaction processors):
* settings-tp (sawtooth-settings-tp:chime)
  > settings-tp -vv -C tcp://validator:4004
* intkey-tp (sawtooth-intkey-tp-python:chime)
  > intkey-tp-python -vv -C tcp://validator:4004
* xo-tp (sawtooth-xo-tp-python:chime)
  > xo-tp-python -vv -C tcp://validator:4004

Apart from these, there are:
* validator (sawtooth-validator:chime)
* devmode-engine (sawtooth-devmode-engine-rust:chime)
  > devmode-engine-rust -C tcp://validator:5050
* rest-api (sawtooth-rest-api:chime)
  > sawtooth-rest-api -C tcp://validator:4004 --bind rest-api:8008
* shell (sawtooth-shell:chime)
  > sawtooth keygen && tail -f /dev/null

> Smart one by shell btw :tears-of-joy:... following output of /dev/null to have the 'infinite wait', similar to while(true), but not CPU intensive... i think so... smart move sawtooth ! Saw some interesting usage by it

Those are the images used,
Specific details:

### validator

It exposes port 4004:4004

It's endpoint code is:

```sh
sawadm keygen
sawtooth keygen my_key
sawset genesis -k /root/.sawtooth/keys/my_key.priv
sawset proposal create \
    -k /root/.sawtooth/keys/my_key.priv \
    sawtooth.consensus.algorithm.name=Devmode \
    sawtooth.consensus.algorithm.version=0.1 \
    -o config.batch
sawadm genesis config-genesis.batch config.batch
sawtooth-validator -vv \
    --endpoint tcp://validator:8800 \
    --bind component:tcp://eth0:4004 \
    --bind network:tcp://eth0:8800 \
    --bind consensus:tcp://eth0:5050
```

#### Observations from last command

The sawtooth-validator command has these args
* endpoint -> tcp://validator:8800
* component -> tcp://eth0:4004
* network -> tcp://eth0:8800
* consensus -> tcp://eth0:5050

### devmode engine

```sh
devmode-engine-rust -C tcp://validator:5050
```

Mereko lagta hai ye 5050 port pe request receive karta hoga isliye wo port pass hua hai, kyunki validator me hai ki 5050 port me consensus, but i don't think validator is starting the consensus... It feels more like microkerenels, only for networks, jisme ek port open kardiya, hamko fark nahi padta ki uspe koi listen kar raha hai ya nahi, but in future some component will, to is case me it becomes quite pluggable... Jo bhi, ye microkernel ke case me interesting hai kafi @adi-g15:READ_THIS

### rest api

```sh
sawtooth-rest-api -C tcp://validator:4004 --bind rest-api:8008
```

Apna pyara mitra, the API

### shell

A container, joki:
1. Initialise key pairs... `sawtooth keygen`
2. Wait infinitely, taki container band na ho... `tail -f /dev/null`

