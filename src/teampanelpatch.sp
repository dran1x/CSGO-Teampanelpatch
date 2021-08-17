#include <sourcemod>
#include <sdktools>
#include <sdkhooks>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo = {

	name = "[CSFIRE.GG] Team Panel Patch",
	author = "CSFIRE.GG - DEV TEAM",
	description = "patches a bug within team panel",
	version = "1.0",
	url = "https://csfire.gg/discord"
};

public void OnPluginStart() {

    HookEvent("player_spawn", Event_OnPlayerSpawn, EventHookMode_Post);
}

public Action Event_OnPlayerSpawn(Event hEvent, const char[] name, bool bDontBroadcast) {

    int iClient = GetClientOfUserId(hEvent.GetInt("userid"));

    if(!IsClientValid(iClient)) {

        return Plugin_Handled;
    }

    hEvent.SetBool("silent", true);
    SetEventBroadcast(hEvent, true);
        
    Event TeamPanel = CreateEvent("player_team");
    TeamPanel.SetInt("userid", GetClientUserId(iClient));
    TeamPanel.FireToClient(iClient);
    CancelCreatedEvent(TeamPanel);
    
    return Plugin_Changed;
}

public bool IsClientValid(int iClient) {

    return (1 <= iClient <= MaxClients && IsClientInGame(iClient) && !IsFakeClient(iClient) && !IsClientSourceTV(iClient));
}
