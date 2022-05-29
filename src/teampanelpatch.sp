#include <sourcemod>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo =
{
	name        = "Team Panel Patch",
	author      = "DRANIX",
	description = "patches a bug within team panel",
	version     = "1.4",
	url         = "https://github.com/dran1x"
}

public void OnPluginStart()
{
	HookEvent("player_spawn", Event_OnPlayerSpawn, EventHookMode_Post);
}

public Action Event_OnPlayerSpawn(Event hEvent, const char[] name, bool bDontBroadcast)
{
	int iClient = GetClientOfUserId(hEvent.GetInt("userid"));

	if (IsFakeClient(iClient))
		return Plugin_Handled;

	hEvent.SetBool("silent", true);
	hEvent.BroadcastDisabled = true;

	Event TeamPanel = CreateEvent("player_team");
	TeamPanel.SetInt("userid", GetClientUserId(iClient));
	TeamPanel.FireToClient(iClient);
	TeamPanel.Cancel();

	return Plugin_Changed;
}

public void OnPluginEnd()
{
	UnhookEvent("player_spawn", Event_OnPlayerSpawn);
}