
MilisecondsPerSecond = 1000;
SecondsPerMinute = 60;
MinutesPerHour = 60;
SecondsPerHour = SecondsPerMinute * MinutesPerHour;		

def ConvertHourMinuteSecondToSeconds(
             ElapsedHours, 
             ElapsedMinutes,
	     ElapsedSeconds) :
  return [ElapsedHours * SecondsPerHour
          + ElapsedMinutes * SecondsPerMinute
          + ElapsedSeconds]

def HowManyElapsedHours(ElapsedSeconds) :
  return [ElapsedSeconds / SecondsPerHour]

def HowManyElapsedMinutes(ElapsedSeconds) :
  return [ElapsedSeconds / SecondsPerMinute 
         - (ElapsedSeconds / SecondsPerHour) * MinutesPerHour]

