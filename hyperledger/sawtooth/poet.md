# POET

## Engine
https://github.com/hyperledger/sawtooth-poet/blob/896e7c6424c8e2af42afefdc4ab030101640c406/engine/sawtooth_poet_engine/main.py

## cli
https://github.com/hyperledger/sawtooth-poet/blob/896e7c6424c8e2af42afefdc4ab030101640c406/cli/sawtooth_poet_cli/main.py#L107-L127

> On chain settings also have addresses like usual state data do
> https://github.com/hyperledger/sawtooth-poet/blob/896e7c6424c8e2af42afefdc4ab030101640c406/core/sawtooth_poet/state/settings_view.py#L37
>
> See, to access on-chain settings, what we do is **compute radix address for given key** - https://github.com/hyperledger/sawtooth-poet/blob/896e7c6424c8e2af42afefdc4ab030101640c406/core/sawtooth_poet/state/settings_view.py#L120-L137

Using func_tools.lru_cache - https://github.com/hyperledger/sawtooth-poet/blob/896e7c6424c8e2af42afefdc4ab030101640c406/core/sawtooth_poet/state/settings_view.py#L53-L57


