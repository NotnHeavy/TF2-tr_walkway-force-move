//////////////////////////////////////////////////////////////////////////////
// MADE BY NOTNHEAVY. USES GPL-3, AS PER REQUEST OF SOURCEMOD               //
//////////////////////////////////////////////////////////////////////////////

// I wrote this at 1 AM. The code sucks but it works. ¯\_(ツ)_/¯

#include <sourcemod>
#include <sdkhooks>
#include <tf2_stocks>

#define PLUGIN_NAME "NotnHeavy - tr_walkway force move"

//////////////////////////////////////////////////////////////////////////////
// PLUGIN INFO                                                              //
//////////////////////////////////////////////////////////////////////////////

static ConVar notnheavy_tr_walkway_speed;
static ConVar notnheavy_tr_walkway_move_nottrack;

//////////////////////////////////////////////////////////////////////////////
// PLUGIN INFO                                                              //
//////////////////////////////////////////////////////////////////////////////

public Plugin myinfo =
{
    name = PLUGIN_NAME,
    author = "NotnHeavy",
    description = "Makes the bots move forward without any hacky velocity stuff.",
    version = "1.1",
    url = "none"
};

//////////////////////////////////////////////////////////////////////////////
// INITIALISATION                                                           //
//////////////////////////////////////////////////////////////////////////////

public void OnPluginStart()
{
    notnheavy_tr_walkway_speed = CreateConVar("notnheavy_tr_walkway_speed", "300.00", "The speed of the bots.", FCVAR_SPONLY);
    notnheavy_tr_walkway_move_nottrack = CreateConVar("notnheavy_tr_walkway_move_nottrack", "1", "Toggles whether bots should still move regardless if they're touching the track.", FCVAR_SPONLY);

    LoadTranslations("common.phrases");
    PrintToServer("--------------------------------------------------------\n\"%s\" has loaded.\n--------------------------------------------------------", PLUGIN_NAME);
}

//////////////////////////////////////////////////////////////////////////////
// FORWARDS                                                                 //
//////////////////////////////////////////////////////////////////////////////

public Action OnPlayerRunCmd(int client, int &buttons, int &impulse, float vel[3], float angles[3], int &weapon, int &subtype, int &cmdnum, int &tickcount, int &seed, int mouse[2])
{
    if (IsFakeClient(client))
    {
        float origin[3];
        GetEntPropVector(client, Prop_Data, "m_vecAbsOrigin", origin);
        if (origin[0] > 1000.00)
            return Plugin_Continue;
        
        if (!notnheavy_tr_walkway_move_nottrack.BoolValue)
        {
            int entity = GetEntPropEnt(client, Prop_Send, "m_hGroundEntity");
            if (!IsValidEntity(entity))
                return Plugin_Continue;

            char buffer[64];
            GetEntityClassname(entity, buffer, sizeof(buffer));
            if (strcmp(buffer, "func_conveyor") != 0)
                return Plugin_Continue;
        }

        float speed = notnheavy_tr_walkway_speed.FloatValue;
        SetEntPropFloat(client, Prop_Send, "m_flMaxspeed", speed);
        vel[0] = speed;
        return Plugin_Changed;
    }
    return Plugin_Continue;
}