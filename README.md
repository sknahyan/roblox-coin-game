# Coin Game 

A Roblox game built in Roblox Studio with Luau.

**Play it:** https://www.roblox.com/games/102834848475640/Coin-game

## Features
- **Coin collection** with respawning coins, all handled by one script
- **Data saving** with DataStores (coins + upgrades), autosave every 60s, and save on server shutdown
- **Speed shop** using a RemoteEvent, with all purchase checks done on the server to prevent exploits
- **Persistent upgrades** that are reapplied on every respawn and rejoin
- **Coin Rush minigame**, a 30-second timed challenge with an on-screen timer synced through player attributes
- **Data migration** that keeps old saves compatible when the save format changed

## Project structure
- `src/server/` contains server scripts (data, shop, coins, minigame)
- `src/client/` contains client-only visuals (coin spinning)
- `src/gui/` contains UI scripts

## What I learned
- Client vs server and why the server must validate purchases
- Using `pcall` to handle failed DataStore requests
- Debugging with the Output window and print statements

