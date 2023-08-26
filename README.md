# (TF2) tr_walkway force move
Bots in tr_walkway_rc2 (and tr_walkway_fix if you use that one, like me) are forced to move by a moving track. This isn't entirely accurate. This plugin uses `usercmd`, like how a normal player would move, instead. That's it. The code sucks though because I wrote this at 1 AM.

# ConVars
**notnheavy_tr_walkway_speed** - Set the bot speed. Set to 300Hu/s by default. Due to TF2 limitations, this is limited up to 520HU/s.
**notnheavy_tr_walkway_move_nottrack** - If set to 0 (false), bots will not move if they are not on the track. Set to 1 (true) by default.
