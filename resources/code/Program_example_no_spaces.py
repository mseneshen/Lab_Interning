MilisecondsPerSecond=1000;
SecondsPerMinute=60;
MinutesPerHour=60;
SecondsPerHour=SecondsPerMinute*MinutesPerHour;		

defConvertHourMinuteSecondToSeconds(
ElapsedHours,
ElapsedMinutes,
ElapsedSeconds):
return[ElapsedHours*SecondsPerHour
+ElapsedMinutes*SecondsPerMinute
+ElapsedSeconds]

defHowManyElapsedHours(ElapsedSeconds):
return[ElapsedSeconds/SecondsPerHour]

defHowManyElapsedMinutes(ElapsedSeconds):
return[ElapsedSeconds/SecondsPerMinute
-(ElapsedSeconds/SecondsPerHour)*MinutesPerHour]

