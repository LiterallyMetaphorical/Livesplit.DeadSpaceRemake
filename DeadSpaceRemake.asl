//Credit to DementedSalad for Origin stuff, and Meta for Steam stuff

/*
Scanning Best Practices:

isLoading
just a boolean, set "Memory Scan Options" to Dead Space.exe - 1 on loading screen, 0 everywhere else
Likely starts with "52"

chapter
Start in Chapter 1, set "Memory Scan Options" to Dead Space.exe - search for "01" regular string for chapter 1, "02" for chapter 2 etc
Likely starts with "4"

IGT
Load up any save. Set "Memory Scan Options" to Dead Space.exe - Scan for a float with unknown initial value
go back in game, walk around for a few seconds, scan for increased value, repeat a few times
load the same save you did initially, scan for decreased value. Walk around, scan for increased value a few times. You should be able to tell which one is right.
Likely starts with "5"
*/

state("Dead Space", "Steam v1.0")
{
    bool    loading : 0x5269494;
    string3 chapter : 0x4BF75A6;
    float   IGT     : 0x52AF390
}

state("Dead Space", "Origin v1.0")
{
    bool 	loading : 0x52C8A14;
	string3 chapter : 0x4C52576;	
	float	IGT		: 0x530E910;
	float	X		: 0x5776120;
	float	Y		: 0x5776124;
	float	Z		: 0x5776128;
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
	{"01","02","03","04","05","06","07","08","09","10","11","12"};
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
	return current.loading && current.chapter == "01";
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
    return current.loading;
}

exit
{
    //pauses timer if the game crashes
	timer.IsGameTimePaused = true;
}
