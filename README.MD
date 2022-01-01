# SP_PresentFinder

This is a quick overview of my PresentFinder resource. This resource was never planned to be public, so it's kinda janky.

![](https://cdn.discordapp.com/attachments/688446856249999459/916694169215459409/unknown.png)

**Requirements:**
- es_extended

## /create
>The sv_create file (which containes the /create command) should never be loaded in a public server. This file is only meant to fill the server config with locations in a dev environment.

**Usage:** /create [lootid]

This command automatically creates an entry in the sv_config file. After reloading the script, the presents appear. LootID is the level of loot that can be found inside the present. The resulting loot can be configured in sv_main.


## /presents
**Usage:** /presents

This tells a player how many presents are left.


## /presentblips
**Usage:** /presentblips

If the player has the required ace, blips are loaded on the map. A red blip means not yet found, a green blip means found.
