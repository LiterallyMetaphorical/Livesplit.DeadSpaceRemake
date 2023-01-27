/*
Scanning Best Practices:

isLoading
loading is a boolean, 1 on loading and 0 elsewhere
Try inside the exe, battlefield had its value in the exe
*/

state("Dead Space", "Steam v1.0")
{
    bool loading : 0x538A3D4;
}

init
{
switch (modules.First().ModuleMemorySize) 
    {
        case 428994560: 
            version = "Steam v1.0";
            break;
    default:
        print("Unknown version detected");
        return false;
    }
}

startup
  {
		if (timer.CurrentTimingMethod == TimingMethod.RealTime)
// Asks user to change to game time if LiveSplit is currently set to Real Time.
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
