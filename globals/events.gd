extends Node

## Coins
signal coin_collected(coin_number: int)
signal next_coin_collected()
signal coins_spawned

## Stamina
signal stamina_updated(amount: float)

## Detection Area
signal detected(body: Node3D)
