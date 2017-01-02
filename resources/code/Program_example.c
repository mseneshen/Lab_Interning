

const MilisecondsPerSecond = 1000;
const SecondsPerMinute = 60;
const MinutesPerHour = 60;
const SecondsPerHour = SecondsPerMinute * MinutesPerHour;		

unsigned int ConvertHourMinuteSecondToSeconds(
             int ElapsedHous, 
             int ElapsedMinutes,
	     int ElapsedSeconds) {
  return ElapsedHours * SecondsPerHour
         + ElapsedMinutes * SecondsPerMinute
    + ElapsedSeconds ;
}

unsigned int HowManyElapsedHours(
	     int ElapsedSeconds) {
  return ElapsedSeconds / SecondsPerHour ;
}

unsigned int HowManyElapsedMinutes(
	     int ElapsedSeconds) {
  return ElapsedSeconds / SecondsPerMinute 
         - (ElapsedSeconds / SecondsPerHour) * MinutesPerHour;
}

