# GTNH-OC-PatternSpammer
A script specifically for automating pattern creation for gluon/magmatter.

## Content

- [About](#about)
- [Install](#install)
- [Setup](#setup)
- [Configuration](#configuration)

<a id="about"></a>

## About

This program is designed to automate the production of the plasma recipes that are required for Degenerate Quark Gluon Plasma and Molten Magmatter.

The program will pattern a fluid crafting pattern assuming it will be used in the Heliofusion Plasma module. The recipe will look different for both fluids and items.

**Items**
1 DUST -> 144 PLASMA

**Fluids**
144 FLUID -> 144 PLASMA

Common plasmas like Helium or Radon that you should have patterned or automated by this point have been commented out, but can easily be reenabled. Additionally, input dusts that are mainly generated as fluids like Rhugnor or Infinity have been switched to fluids to make automation smoother.

<a id="install"></a>

## Install

To install the program, you need a computer with:
- Graphics Card (Tier 3): 1
- Central Processing Unit (CPU) (Tier 3): 1
- Memory (Tier 3.5): 2
- Hard Disk Drive (Tier 3) (4MB): 1
- EEPROM (Lua BIOS): 1
- Internet Card: 1

Install the basic Open OS on your computer.
Then run the command to start the installer.

```shell
pastebin run yiL1tRMJ
```

After setting up the blocks and the config, to run the program just type `patternspammer`.

<a id="setup"></a>

## Setup

To build a setup, you will need:

- Transposer: 1
- Adapter: 1
- Database Upgrade (Tier 3): 1
- OC Pattern Editor: 1
- Barrel
- Compressed Chest

The setup is very simple.

![Top setup](/docs/topview.png)

![Side setup](/docs/sideview.png)

In the barrel, put **3 stacks** of **encoded** dummy fluid patterns. I used this recipe. You can CTRL + SHIFT click on the pattern terminal to get a full stack of the same pattern at once.

![Pattern](/docs/recipe.png)

<a id="configuration"></a>

## Configuration

Configuration is just as simple as setup. Just do `edit patternspammer.lua` and edit the variables in the **Config** section to the direction of your chest/barrel/ocp.

```lua
local ICHESTSIDE = sides.north
local IFSIDE = sides.west
local OCHESTSIDE = sides.south
```




