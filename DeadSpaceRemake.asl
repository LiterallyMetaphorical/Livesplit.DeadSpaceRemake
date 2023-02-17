// Dead Space Remake Load Remover & Autosplitter Version 1.1.0 (02/02/2023)
// Supports LRT & Autosplits
// Splits can be obtained from
// Script by Meta & TheDementedSalad
// Steam Pointers by Meta
// EA Pointers by TheDementedSalad

/*
Scanning Best Practices:

bool loading
just a boolean, set "Memory Scan Options" to Dead Space.exe - 1 on loading screen, 0 everywhere else
Likely starts with "52"

string chapter
Start in Chapter 1, set "Memory Scan Options" to Dead Space.exe - search for "01" regular string for chapter 1, "02" for chapter 2 etc
Likely starts with "4"

float IGT
Load up any save. Set "Memory Scan Options" to Dead Space.exe - Scan for a float with unknown initial value
go back in game, walk around for a few seconds, scan for increased value, repeat a few times
load the same save you did initially, scan for decreased value. Walk around, scan for increased value a few times. You should be able to tell which one is right.
Likely starts with "5"

float XYZ
set "Memory Scan Options" to Dead Space.exe. For this process we're going to be looking for float Y first (up and down)
Get to a ramp or staircase in game. At the top of the ramp, scan for unknown initial value. Go down, scan for decreased. Go back up, scan for increased.
Repeat this process and look for an address starting with "57" and ends with "4", that should be your "Y" value. Bring this static address into your table.
CTRL - C the address, and then CTRL - V back into the table. Inside "Adjust address by", enter 4, click paste. It should end with 8 - this is your Z value
Copy and Paste your Y value again, this time adjust the address by -4, click paste. It should end with 0 - this is your X value.
X ends with 0
Y ends with 4
Z ends with 8

float inGame

set "Memory Scan Options" to Dead Space.exe. Set Scan Type to "All"
Scan for 0 on main menu, 1 while in game, 0 on pause menu. 
Continue this process until you find a static address starting with "4" and ending with "4"

string map

load up a save where you return to the Flight Lounge for the second time. Feel free to DM Meta and ask for "Find Map Pointer" save
Standing in the flight lounge, scan for a normal string "flightlounge".  Walk into the hallway with the bathroom and type "restroomcorridor"
There should be one address, add it to the table but then modify the last character from a "D" to a "0"
Pointer scan, and try to match the offsets.
*/

state("Dead Space", "Steam v1.0")
{
    bool	loading 	: 0x5269494;
    ushort	loadBuff	: 0x4DB008C;
    float	IGT     	: 0x52AF390;
    float	X       	: 0x57045A0;
    float	Y       	: 0x57045A4;
    float	Z       	: 0x57045A8;
    float	inGame		: 0x4DB0084;
    string3	chapter 	: 0x4BF75A6;
    string99	map     	: 0x04C570A0, 0x10, 0x58, 0xB8, 0x0;
}

state("Dead Space", "Origin v1.0")
{
    bool 	loading 	: 0x52C8A14;
    ushort   	loadBuff 	: 0x4E0B02C;
    float	IGT     	: 0x530E910;
    float	X		: 0x5776120;
    float	Y		: 0x5776124;
    float	Z		: 0x5776128;
    float   	inGame  	: 0x4E0B024;
    string3  	chapter 	: 0x4C52576;
    string30 	map     	: 0x4CB2070, 0x10, 0x58, 0xB8, 0x0;
}

state("Dead Space", "Steam v1.1")
{
    bool     	loading 	: 0x5269494;
    ushort   	loadBuff 	: 0x4DB008C;
    float    	IGT     	: 0x52AF390;
    float    	X       	: 0x57045A0;
    float    	Y       	: 0x57045A4;
    float    	Z       	: 0x57045A8;
    float    	inGame  	: 0x4DB0084;
    string3  	chapter 	: 0x4BF75A6;
    string99 	map     	: 0x04C570B0, 0x10, 0x58, 0xB8, 0x0;
}

state("Dead Space", "Origin v1.1")
{
    bool         loading	: 0x52C9A14;
    ushort       loadBuff	: 0x4E0C03C;
    float        IGT		: 0x530F910;
    float        X		: 0x5777120;
    float        Y		: 0x5777124;
    float        Z		: 0x5777128;
    float        inGame		: 0x4E0C034;
    string2      chapter	: 0x4C53576;
    string30     map		: 0x4CB3080, 0x10, 0x58, 0xB8, 0x0;
}

state("Dead Space", "Steam v1.2")
{
    bool     	loading 	: 0x526A494;
    ushort	loadBuff	: 0x4DB109C;
    float    	IGT		: 0x52B0430;
    float    	X		: 0x5705620;
    float    	Y		: 0x5705624;
    float    	Z		: 0x5705628;
    float    	inGame		: 0x4DB1094;
    string2 	chapter		: 0x4BF85A6;
    string99 	map		: 0x04C580B0, 0x10, 0x58, 0xB8, 0x0;
}

state("Dead Space", "Origin v1.2")
{
    bool 	loading 	: 0x52CCA14;
    ushort	loadBuff	: 0x4E0F03C;
    float	IGT		: 0x53129B0;
    float	X		: 0x577A220;
    float	Y		: 0x577A224;
    float	Z		: 0x577A228;
    float 	inGame		: 0x4E0F034;
    string2	chapter 	: 0x4C56576;
    string30	map		: 0x4CB6080, 0x10, 0x58, 0xB8, 0x0;
}

state("Dead Space", "Origin v1.3")
{
    bool 	loading 	: 0x52C6A74;
    ushort	loadBuff	: 0x4E0907C;
    float	X		: 0x5798680;
    float	Y		: 0x5798684;
    float	Z		: 0x5798688;
    float 	inGame		: 0x4E0F034;
    string2 	chapter 	: 0x4C56576;
    string30 	map		: 0x4CB00B0, 0x10, 0x58, 0xB8, 0x0;
}

init
{
switch (modules.First().ModuleMemorySize) 
    {
        case 428994560: 
            version = "Steam v1.0";
            break;
		case 412131328: 
            version = "Origin v1.0";
            break;
        case 430182400: 
            version = "Steam v1.1";
            break;
        case 414437376: 
            version = "Origin v1.1";
            break;
        case 430497792: 
            version = "Steam v1.2";
            break;
        case 402546688: 
            version = "Origin v1.2";
            break;
	case 416350208 : 
            version = "Origin v1.3";
            break;
    default:
        print("Unknown version detected");
        return false;
    }
}

startup
  {
	// Asks user to change to game time if LiveSplit is currently set to Real Time.
		if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {        
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Dead Space",
            MessageBoxButtons.YesNo,MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }
	
	vars.completedSplits = new List<string>();
	
	vars.splits = new List<string>()
	{"02","03","04","05","06","07","08","09","10","11","12"};
}

onStart
{
    // This makes sure the timer always starts at 0.00
    timer.IsGameTimePaused = true;
}

update
{
	//DEBUG CODE 
	//print(modules.First().ModuleMemorySize.ToString());
	//print(current.loading.ToString());
	
	if(timer.CurrentPhase == TimerPhase.NotRunning)
	{
		vars.completedSplits.Clear();
	}
 
}

start
{
	return current.map == "Hangar.Rooms.ChaseHall" && !current.loading && old.loading && current.chapter == "01";
}

//return !current.loading && current.X > -15f && current.X < -13f && current.Y < 56f && current.Y > 55f && current.Z < -13 && current.Z > -15;

split
{
	if (current.chapter != old.chapter && vars.splits.Contains(current.chapter) && !vars.completedSplits.Contains(current.chapter)){
		vars.completedSplits.Add(current.chapter);
		return true;
	}
}

isLoading
{
    return current.loading || current.loadBuff == 0 || current.inGame == 0;
}

exit
{
    //pauses timer if the game crashes
	timer.IsGameTimePaused = true;
}
