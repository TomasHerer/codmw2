/* Plugin generated by AMXX-Studio */

#include < amxmodx >
#include < amxmisc >
#include < cstrike >
#include < engine >
#include < fakemeta >
#include < fvault >
#include < hamsandwich >


#define PLUGIN		"Nastavenia"
#define VERSION		"1.0"
#define AUTHOR		"Origin Corp."

#define TASK_ZOOM_DISTANCE	40

#define SETT_MENU	(1<<0)|(1<<1)|(1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<9)

new const fDataBase[] = "codmwsetting";

enum _:VALUE
{
	KILLZOOM, MESSAGE, EFFECT, SKINS
};

new nSETTING[VALUE][33];

new g_maxplayers;

new const v_weaponmodels[][] = 
{
	"models/codmw/v_ak47.mdl",		// 00
	"models/codmw/v_aug.mdl",		// 01
	"models/codmw/v_awp.mdl", 		// 02
	"models/codmw/v_c4.mdl",		// 03
	"models/codmw/v_deagle.mdl",		// 04
	"models/codmw/v_elite.mdl",		// 05
	"models/codmw/v_famas.mdl",		// 06
	"models/codmw/v_fiveseven.mdl",		// 07
	"models/codmw/v_flashbang.mdl",		// 08
	"models/codmw/v_g3sg1.mdl",		// 09
	"models/codmw/v_galil.mdl",		// 10
	"models/codmw/v_glock18.mdl",		// 11
	"models/codmw/v_hegranade.mdl",		// 12
	"models/codmw/v_knife.mdl",		// 13
	"models/codmw/v_m3.mdl",		// 14
	"models/codmw/v_m4a1.mdl",		// 15
	"models/codmw/v_m249.mdl",		// 16
	"models/codmw/v_mac10.mdl",		// 17
	"models/codmw/v_mp5.mdl",		// 18
	"models/codmw/v_p90.mdl",		// 19
	"models/codmw/v_p228.mdl", 		// 20
	"models/codmw/v_scout.mdl",		// 21
	"models/codmw/v_sg550.mdl",		// 22
	"models/codmw/v_sg552.mdl",		// 23
	"models/codmw/v_smokegranade.mdl",	// 24
	"models/codmw/v_tmp.mdl",		// 25
	"models/codmw/v_ump45.mdl",		// 26
	"models/codmw/v_usp.mdl",		// 27
	"models/codmw/v_xm1014.mdl"		// 28
};

new const p_weaponmodels[][] = {
	"models/codmw/p_ak47.mdl",		// 00
	"models/codmw/p_aug.mdl",		// 01
	"models/codmw/p_awp.mdl",		// 02
	"models/codmw/p_c4.mdl",		// 03
	"models/codmw/p_deagle.mdl",		// 04
	"models/codmw/p_elite.mdl",		// 05
	"models/codmw/p_famas.mdl",		// 06
	"models/codmw/p_fiveseven.mdl",		// 07
	"models/codmw/p_flashbang.mdl",		// 08
	"models/codmw/p_g3sg1.mdl",		// 09
	"models/codmw/p_galil.mdl",		// 10
	"models/codmw/p_glock18.mdl",		// 11
	"models/codmw/p_he.mdl",		// 12
	"models/codmw/p_knife.mdl",		// 13
	"models/codmw/p_m3.mdl",		// 14
	"models/codmw/p_m4a1.mdl",		// 15
	"models/codmw/p_m249.mdl",		// 16
	"models/codmw/p_mac10.mdl",		// 17
	"models/codmw/p_mp5.mdl",		// 18
	"models/codmw/p_p90.mdl",		// 19
	"models/codmw/p_p228.mdl",		// 20
	"models/codmw/p_scout.mdl",		// 21
	"models/codmw/p_sg550.mdl",		// 22
	"models/codmw/p_sg552.mdl",		// 23
	"models/codmw/p_sg.mdl",		// 24
	"models/codmw/p_tmp.mdl",		// 25
	"models/codmw/p_ump45.mdl",		// 26
	"models/codmw/p_usp.mdl",		// 27
	"models/codmw/p_xm1014.mdl"		// 28
};

new const old_w_models[][]  =
{
	"models/w_ak47.mdl",			// 00
	"models/w_aug.mdl",			// 01
	"models/w_awp.mdl",			// 02
	"models/w_c4.mdl",			// 03
	"models/w_deagle.mdl",			// 04
	"models/w_elite.mdl",			// 05
	"models/w_famas.mdl",			// 06
	"models/w_fiveseven.mdl",		// 07
	"models/w_flashbang.mdl",		// 08
	"models/w_g3sg1.mdl",			// 09
	"models/w_galil.mdl",			// 10
	"models/w_glock18.mdl",			// 11
	"models/w_hegrenade.mdl",		// 12
	"models/w_knife.mdl",			// 13
	"models/w_m3.mdl",			// 14
	"models/w_m4a1.mdl",			// 15
	"models/w_m249.mdl",			// 16
	"models/w_mac10.mdl",			// 17
	"models/w_mp5.mdl",			// 18
	"models/w_p90.mdl",			// 19
	"models/w_p228.mdl",			// 20
	"models/w_scout.mdl",			// 21
	"models/w_sg550.mdl", 			// 22
	"models/w_sg552.mdl",			// 23
	"models/w_smokegrenade.mdl",		// 24
	"models/w_tmp.mdl",			// 25
	"models/w_ump45.mdl",			// 26
	"models/w_usp.mdl",			// 27
	"models/w_xm1014.mdl",			// 28
	"models/w_backpack.mdl"			// 29
};
new const new_w_models[][]  = 
{
	"models/codmw/w_ak47.mdl",		// 00
	"models/codmw/w_aug.mdl",		// 01
	"models/codmw/w_awp.mdl",		// 02
	"models/codmw/w_c4.mdl",		// 03
	"models/codmw/w_deagle.mdl",		// 04
	"models/codmw/w_elite.mdl",		// 05
	"models/codmw/w_famas.mdl",		// 06
	"models/codmw/w_fiveseven.mdl",		// 07
	"models/codmw/w_flashbang.mdl",		// 08
	"models/codmw/w_g3sg1.mdl",		// 09
	"models/codmw/w_galil.mdl",		// 10
	"models/codmw/w_glock18.mdl",		// 11
	"models/codmw/w_he.mdl",		// 12
	"models/codmw/w_knife.mdl",		// 13
	"models/codmw/w_m3.mdl",		// 14
	"models/codmw/w_m4a1.mdl",		// 15
	"models/codmw/w_m249.mdl",		// 16
	"models/codmw/w_mac10.mdl",		// 17
	"models/codmw/w_mp5.mdl",		// 18
	"models/codmw/w_p90.mdl",		// 19
	"models/codmw/w_p228.mdl",		// 20
	"models/codmw/w_scout.mdl",		// 21
	"models/codmw/w_sg550.mdl",		// 22
	"models/codmw/w_sg552.mdl",		// 23
	"models/codmw/w_sg.mdl",		// 24
	"models/codmw/w_tmp.mdl",		// 25
	"models/codmw/w_ump45.mdl",		// 26
	"models/codmw/w_usp.mdl",		// 27
	"models/codmw/w_xm1014.mdl",		// 28
	"models/codmw/w_backpack.mdl"		// 29
};

new v_knifemodelT[] = "models/codmw/v_knife_r.mdl";

new const s_startsound2[][] = 
{
	"codmw/cod_bgsound.mp3",
	"codmw/cod_bgsound2.mp3",
	"codmw/cod_bgsound3.mp3",
	"codmw/cod_bgsound4.mp3"
};

new const s_radiosound[][] = 
{ 
	"codmw/radio01.wav", "codmw/radio02.wav", "codmw/radio03.wav", "codmw/radio04.wav", "codmw/radio05.wav",
	"codmw/radio06.wav", "codmw/radio07.wav", "codmw/radio08.wav", "codmw/radio09.wav", "codmw/radio10.wav" 
};

public plugin_precache( )
{
	
	for ( new i = 0; i < sizeof ( v_weaponmodels ); i++ )
		precache_model( v_weaponmodels[ i ] );

	for ( new i = 0; i < sizeof ( p_weaponmodels ); i++ )
		precache_model( p_weaponmodels[ i ] );
	
	for ( new i = 0; i < sizeof ( new_w_models ); i++ )
		precache_model( new_w_models[ i ] );
		
	precache_model( v_knifemodelT );
	
	for (new i = 0; i < sizeof(s_startsound2); i++)
	precache_sound(s_startsound2[i]);
	
	for (new i = 0; i < sizeof(s_radiosound); i++)
		precache_sound(s_radiosound[i]);
}

public plugin_init( )
{
	register_plugin( PLUGIN, VERSION, AUTHOR );
	
	//register_impulse( 100, "Func_ChangeModels" );
	
	RegisterHam( Ham_Killed, "player", "Ham_PlayerKilled" );
	
	register_logevent( "LogEvent_RoundStart", 2, "1=Round_Start" ); 
	
	register_event( "CurWeapon","Event_CurWeapon","be", "1=1" );
	
	register_forward( FM_SetModel,"W_Model_Hook",1 );
	
	register_clcmd( "say /nastavenia", 	"Cmd_HerneNastavenia" );
	register_clcmd( "say_team /nastavenia",	"Cmd_HerneNastavenia" );
	register_clcmd( "say /setting", 	"Cmd_HerneNastavenia" );
	register_clcmd( "say_team /setting", 	"Cmd_HerneNastavenia" );
	register_clcmd( "codsetting", 		"Cmd_HerneNastavenia" );
	
	register_menucmd( register_menuid("SettingMenuSelect"), SETT_MENU, "Cmd_HerneNastavenia_Handler" );
	
	g_maxplayers 		= get_maxplayers( );
	set_task( 60.0, "Pomoc" );
	set_task( 20.0, "Func_BGRadio" );
	
}

public client_connect( id )
{
	nSETTING[ KILLZOOM ][ id ] = 1;
	nSETTING[ MESSAGE ][ id ] = 1;
	nSETTING[ EFFECT ][ id ] = 1;
	nSETTING[ SKINS ][ id ] = 1;
	
	LoadData( id );
}

public client_disconnect( id ) SaveData( id );

public Cmd_HerneNastavenia(id)
{
	new SettingTexT[556];
	
	new nLen = format( SettingTexT, 555, "\rHerne Nastavenia:" );
	nLen += format( SettingTexT[nLen], 555-nLen, "^n\y1. \wKill Zoom [%s\w]", ( nSETTING[ KILLZOOM ][ id ] == 1 ) ? "\yZAPNUTE" : "\rVYPNUTE" );
	nLen += format( SettingTexT[nLen], 555-nLen, "^n\d - Priblizenie obrazovky na utocnika." );
	nLen += format( SettingTexT[nLen], 555-nLen, "^n\y2. \wInfo Spravy [%s\w]" , ( nSETTING[ MESSAGE ][ id ] == 1 ) ? "\yZAPNUTE" : "\rVYPNUTE" );
	nLen += format( SettingTexT[nLen], 555-nLen, "^n\d - Zobrazenie Pomocnych sprav v chate." );
	nLen += format( SettingTexT[nLen], 555-nLen, "^n\y3. \wStart Effect [%s\w]" , ( nSETTING[ EFFECT ][ id ] == 1 ) ? "\yZAPNUTE" : "\rVYPNUTE" );
	nLen += format( SettingTexT[nLen], 555-nLen, "^n\d - Na zaciatku kola sa spusti hudba + zeleny fade.." );
	nLen += format( SettingTexT[nLen], 555-nLen, "^n\y4. \wModely Zbrani [%s\w]" , ( nSETTING[ SKINS ][ id ] == 1 ) ? "\yZAPNUTE" : "\rVYPNUTE" );
	nLen += format( SettingTexT[nLen], 555-nLen, "^n\d - Nove modely pre zbrane." );
	
	nLen += format( SettingTexT[nLen], 555-nLen, "^n\y6. Herne Menu" );
	nLen += format( SettingTexT[nLen], 555-nLen, "^n^n\y0. \wKoniec" );
	
	show_menu(id, SETT_MENU, SettingTexT, -1, "SettingMenuSelect" );
}

public Cmd_HerneNastavenia_Handler(id, key) 
{
	switch ( key ) 
	{
		case 0:
		{
			nSETTING[ KILLZOOM ][ id ] = ( nSETTING[ KILLZOOM ][ id ] == 1 ) ? 0 : 1;
			Cmd_HerneNastavenia(id);
		}
		case 1:
		{
			nSETTING[ MESSAGE ][ id ] = ( nSETTING[ MESSAGE ][ id ] == 1 ) ? 0 : 1;
			Cmd_HerneNastavenia(id);
		}
		case 2:
		{
			nSETTING[ EFFECT ][ id ] = ( nSETTING[ EFFECT ][ id ] == 1 ) ? 0 : 1;
			Cmd_HerneNastavenia(id);
		}
		case 3:
		{
			nSETTING[ SKINS ][ id ] = ( nSETTING[ SKINS ][ id ] == 1 ) ? 0 : 1;
			Cmd_HerneNastavenia( id );
		}
		case 4:
		{
			client_cmd( id, "say /cod" );
		}
		case 9: return PLUGIN_HANDLED;
	}
	SaveData( id );
	return PLUGIN_HANDLED;
}
/*
public Func_ChangeModels( id )
{
	if ( nSETTING[ SKINS ][ id ] == 1 )
	{
		nSETTING[ SKINS ][ id ] = 0;
		ColorMsg( id, "^1[^4%s^1] Modely/Skiny zbrani boli^4 VYPNUTE", PLUGIN );
	} else if ( nSETTING[ SKINS ][ id ] == 0 )
	{
		nSETTING[ SKINS ][ id ] = 1;
		ColorMsg( id, "^1[^4%s^1] Modely/Skiny zbrani boli^4 ZAPNUTE", PLUGIN );
	}
	return PLUGIN_CONTINUE;
}*/

public Ham_PlayerKilled( victim, attacker )
{
	if ( !is_user_connected( attacker ) || !is_user_connected( victim ) || is_user_bot( attacker ) || attacker == victim || !attacker)
		return HAM_IGNORED;

	if ( nSETTING[ KILLZOOM ][victim] )
	{
		if ( attacker != victim || is_user_connected( attacker ) )
		{
			set_task( 0.1, "Func_KillerZoomEffect", victim );
		}
	} else return PLUGIN_HANDLED;
	return HAM_IGNORED;
}


public LogEvent_RoundStart()    
{
	static ent, classname[8], model[32];
	ent = engfunc( EngFunc_FindEntityInSphere, g_maxplayers, Float:{ 0.0, 0.0 ,0.0 }, 4800.0 );
	
	for ( new id = 0; id <= g_maxplayers; id++ )
	{
		if ( !is_user_alive( id ) )
			continue;
		
		if ( nSETTING[ EFFECT ][ id ] )
		{
			set_task(0.1, "FuncStartFade", id);
			new rand = random_num(1,4);
			
			switch( rand )
			{
				case 1: client_cmd( 0, "mp3 play sound/%s", s_startsound2[ 0 ] );
				case 2: client_cmd( 0, "mp3 play sound/%s", s_startsound2[ 1 ] );
				case 3: client_cmd( 0, "mp3 play sound/%s", s_startsound2[ 2 ] );
				case 4: client_cmd( 0, "mp3 play sound/%s", s_startsound2[ 3 ] );
			}
		}
	}
	
	while ( ent )
	{
		if ( pev_valid( ent ) )
		{
			pev( ent, pev_classname, classname, 7 );
			if ( containi( classname,"armoury" )!=-1 )
			{
				pev( ent, pev_model, model, 31 );
				W_Model_Hook( ent, model );
			}
		}
		ent = engfunc( EngFunc_FindEntityInSphere, ent, Float:{ 0.0 ,0.0 ,0.0 }, 4800.0 );
	}
}

public Event_CurWeapon( id, ent )
{		
	new weapon = read_data( 2 );
	
	if ( nSETTING[ SKINS ][ id ] )
	{
		switch (weapon)
		{
			case CSW_AK47:
			{ 
				set_pev( id, pev_viewmodel2, v_weaponmodels[0] );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[0] );
			}
			case CSW_AUG:
			{ 
				set_pev( id, pev_viewmodel2, v_weaponmodels[1] );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[1] );
			}
			case CSW_AWP:
			{ 
				set_pev( id, pev_viewmodel2, v_weaponmodels[2] );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[2] );
			}
			case CSW_C4:
			{ 
				set_pev( id, pev_viewmodel2, v_weaponmodels[3] );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[3] );
			}
			case CSW_DEAGLE:
			{ 
				set_pev( id, pev_viewmodel2, v_weaponmodels[4] );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[4] );
			}	
			case CSW_ELITE:
			{ 
				set_pev( id, pev_viewmodel2, v_weaponmodels[5] );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[5] );
			}
			case CSW_FAMAS:
			{ 
				set_pev( id, pev_viewmodel2, v_weaponmodels[6] );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[6] );
			}
			case CSW_FIVESEVEN:
			{ 
				set_pev( id, pev_viewmodel2, v_weaponmodels[7] );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[7] );
			}
			case CSW_FLASHBANG:
			{ 
				set_pev( id, pev_viewmodel2, v_weaponmodels[8]);
				set_pev( id, pev_weaponmodel2, p_weaponmodels[8] );
			}
			case CSW_G3SG1:
			{ 
				set_pev( id, pev_viewmodel2, v_weaponmodels[9] );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[9] );
			}
			case CSW_GALIL:
			{ 
				set_pev( id, pev_viewmodel2,  v_weaponmodels[10] );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[10] );
			}
			case CSW_GLOCK18:
			{ 
				set_pev( id, pev_viewmodel2, v_weaponmodels[11] );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[11] );
			}
			case CSW_HEGRENADE:
			{ 			
				set_pev( id, pev_viewmodel2, v_weaponmodels[12] );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[12] );
			}
			case CSW_KNIFE:
			{ 
				set_pev( id, pev_viewmodel2, v_weaponmodels[13] );
				set_pev( id, pev_viewmodel2, v_knifemodelT );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[13] );
			}
			case CSW_M3:
			{ 
				set_pev( id, pev_viewmodel2,  v_weaponmodels[14] );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[14] );
			}
			case CSW_M4A1:
			{ 
				set_pev( id, pev_viewmodel2, v_weaponmodels[15] );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[15] );
			}
			case CSW_M249:
			{ 
				set_pev( id, pev_viewmodel2, v_weaponmodels[16] );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[16] );
			}
			case CSW_MAC10:
			{ 
				set_pev( id, pev_viewmodel2, v_weaponmodels[17] );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[17] );
			}
			case CSW_MP5NAVY:
			{ 
				set_pev( id, pev_viewmodel2, v_weaponmodels[18] );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[18] );
			}
			case CSW_P90:
			{ 
				set_pev( id, pev_viewmodel2, v_weaponmodels[19] );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[19] );
			}
			case CSW_P228:
			{ 
				set_pev( id, pev_viewmodel2, v_weaponmodels[20] );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[20] );
			}
			case CSW_SCOUT:
			{ 
				set_pev( id, pev_viewmodel2, v_weaponmodels[21] );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[21] );
			}
			case CSW_SG550:
			{ 
				set_pev( id, pev_viewmodel2, v_weaponmodels[22] );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[22] );
			}
			case CSW_SG552:
			{ 
				set_pev( id, pev_viewmodel2, v_weaponmodels[23] );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[23] );
			}
			case CSW_SMOKEGRENADE:
			{ 
				set_pev( id, pev_viewmodel2, v_weaponmodels[24] );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[24] );
			}
			case CSW_TMP:
			{ 
				set_pev( id, pev_viewmodel2, v_weaponmodels[25] );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[25] );
			}
			case CSW_UMP45:
			{ 
				set_pev( id, pev_viewmodel2, v_weaponmodels[26] );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[26] );
			}
			case CSW_USP:
			{ 
				set_pev( id, pev_viewmodel2, v_weaponmodels[27] );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[27] );
			}
			case CSW_XM1014:
			{ 
				set_pev( id, pev_viewmodel2, v_weaponmodels[28] );
				set_pev( id, pev_weaponmodel2, p_weaponmodels[28] );
			}
		}
	}
	return PLUGIN_HANDLED;
}


public W_Model_Hook( ent,model[ ] )
{
	if ( equali( model, old_w_models[ 0 ] ) )
	{
		engfunc( EngFunc_SetModel, ent, new_w_models[ 0 ] );
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[1]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[1]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[2]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[2]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[3]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[3]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[4]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[4]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[5]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[5]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[6]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[6]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[7]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[7]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[8]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[8]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[9]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[9]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[10]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[10]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[11]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[11]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[12]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[12]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[13]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[13]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[14]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[14]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[15]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[15]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[16]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[16]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[17]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[17]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[18]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[18]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[19]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[19]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[20]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[20]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[21]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[21]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[22]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[22]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[23]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[23]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[24]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[24]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[25]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[25]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[26]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[26]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[27]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[27]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[28]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[28]);
		return FMRES_SUPERCEDE;
	}
	if(equali(model, old_w_models[29]))
	{
		engfunc(EngFunc_SetModel,ent,new_w_models[29]);
		return FMRES_SUPERCEDE;
	}
	return FMRES_IGNORED;
}

public SaveData( id )
{
	new steamid[ 35 ];
	get_user_authid(id, steamid, sizeof ( steamid ) - 1);

	new fkey[ 54 ];
	new fdata[ 26 ];
	format( fkey,53, "%s-codmwsetting",steamid );
	format( fdata, 25, "%i#%i#%i#%i", nSETTING[ KILLZOOM ][ id ], nSETTING[ MESSAGE ][ id ], nSETTING[ EFFECT ][ id ], nSETTING[ SKINS ][ id ] );

	fvault_set_data( fDataBase, fkey, fdata );
}

public LoadData( id )
{
	new steamid[ 35 ];
	get_user_authid(id, steamid, sizeof ( steamid ) - 1);

	new fkey[ 54 ];
	new fdata[ 26 ];
	format( fkey,53, "%s-codmwsetting",steamid );
	format( fdata, 25, "%i#%i#%i#%i", nSETTING[ KILLZOOM ][ id ], nSETTING[ MESSAGE ][ id ], nSETTING[ EFFECT ][ id ], nSETTING[ SKINS ][ id ] );
	fvault_get_data( fDataBase, fkey, fdata, 255 );
	
	replace_all( fdata, 25, "#", " ");
	
	new fKillZoom[32], fMessage[32], fEffect[32], fSkins[32];
	
	parse( fdata, fKillZoom, 31, fMessage, 31, fEffect, 31, fSkins, 31 );
	
	nSETTING[ KILLZOOM ][ id ] = str_to_num( fKillZoom );
	nSETTING[ MESSAGE ][ id ] = str_to_num( fMessage );
	nSETTING[ EFFECT ][ id ] = str_to_num( fEffect );
	nSETTING[ SKINS ][ id ] = str_to_num( fSkins );
} 

public Pomoc(id)
{
	if ( !nSETTING[ MESSAGE ][ id ] )
		return PLUGIN_HANDLED;
		
	new msg = random_num(1, 10);
	switch ( msg )
	{
		case 1: ColorMsg( 0, "^1[^4%s^1] Napis^4 /prikazy^1 pre otvorenie prikazov na servery.", PLUGIN );
		case 2: ColorMsg( 0, "^1[^4%s^1] Stlac^4 M^1 alebo napis^4 /menu^1,^4 /cod^1 pre otvorenie hlavneho menu.", PLUGIN );
		case 3: ColorMsg( 0, "^1[^4%s^1] Pre zistenie informacii o iteme napis^4 /item^1.", PLUGIN );
		case 4: ColorMsg( 0, "^1[^4%s^1] Pre zistenie informacii o triede napis^4 /classinfo^1.", PLUGIN );
		case 5: ColorMsg( 0, "^1[^4%s^1] Pre zistenie informacii o itemoch napis^4 /iteminfo^1.", PLUGIN );
		case 6: ColorMsg( 0, "^1[^4%s^1] Stlac^4 N^1 alebo napis^4 /shop^1 pre otvorenie obchodu.", PLUGIN );
		case 7: ColorMsg( 0, "^1[^4%s^1] Stlac^4 G^1 pre zahodenie itemu.", PLUGIN );
		case 8: ColorMsg( 0, "^1[^4%s^1] Stlac^4 O^1 pre otvorenie nastavenia modu.", PLUGIN );
		case 9: ColorMsg( 0, "^1[^4%s^1] Stlac^4 C^1 (radio3) pre vyuzitie itemu.", PLUGIN );
		case 10: ColorMsg( 0, "^1[^4%s^1] Nabinduj si vyuzitie itemu ^4 bind ^"pismeno^" +coduseitem^1.", PLUGIN );
	}
	set_task(60.0, "Pomoc");
	return PLUGIN_CONTINUE;
}

public Func_BGRadio(id)
{
	new radio = random_num(1, 10);
	switch ( radio )
	{
		case 1: client_cmd(0, "spk sound/%s", s_radiosound[0]);
		case 2: client_cmd(0, "spk sound/%s", s_radiosound[1]);
		case 3: client_cmd(0, "spk sound/%s", s_radiosound[2]);
		case 4: client_cmd(0, "spk sound/%s", s_radiosound[3]);
		case 5: client_cmd(0, "spk sound/%s", s_radiosound[4]);
		case 6: client_cmd(0, "spk sound/%s", s_radiosound[5]);
		case 7: client_cmd(0, "spk sound/%s", s_radiosound[6]);
		case 8: client_cmd(0, "spk sound/%s", s_radiosound[7]);
		case 9: client_cmd(0, "spk sound/%s", s_radiosound[8]);
		case 10: client_cmd(0, "spk sound/%s", s_radiosound[9]);
	}
	set_task( 20.0, "Func_BGRadio", id );
	return PLUGIN_CONTINUE;
}

public Func_KillerZoomEffect( id )
{
	message_begin( MSG_ONE, get_user_msgid("SetFOV"), _, id );
	write_byte( TASK_ZOOM_DISTANCE );
	message_end( );
}

public FuncStartFade(id)
{
	message_begin( MSG_ONE_UNRELIABLE, get_user_msgid("ScreenFade"), _, id );
	write_short( 1000 );	// duration
	write_short( 1000 );	// hold time
	write_short( SF_FADE_IN );	// flags
	write_byte( 010 );	// red
	write_byte( 255 );	// green
	write_byte( 010 );	// blue
	write_byte( 120 );	// alpha
	message_end();
}

stock ColorMsg( const id , const input[] , any:... ) 
{	
	new count = 1 , players[ 32 ];
	static msg[ 191 ];
	vformat( msg , 190 , input , 3 );
	
	replace_all( msg , 190 , "!g" , "^4" ); // Green Color
	replace_all( msg , 190 , "!y" , "^1" ); // Default Color
	replace_all( msg , 190 , "!t" , "^3" ); // Team Color
	
	
	if ( id ) players[ 0 ] = id; else get_players( players , count , "ch" ); 
	{
		for ( new i = 0; i < count; i++ ) 
		{
			if ( is_user_connected( players[ i ] ) ) 
			{
				message_begin( MSG_ONE_UNRELIABLE , get_user_msgid( "SayText" ) , _ , players[ i ] ); 
				write_byte( players[ i ] );
				write_string( msg );
				message_end( );
			}
		}
	}
}
