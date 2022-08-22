var time : float;
 var lapTime : float;
 var started : boolean = false;
 var bestlap : float;
 
 function Update(){
	 if(started){
 time = Time.time - lapTime;
 }}
 
 function OnGUI(){if(started){
 GUI.Label (Rect (10,10,310,100), "current: " + FormatTime(time));
 GUI.Label (Rect (10,30,310,100), "best: " + FormatTime(bestlap));
 }}
 
 function StartNewLap(){
 lapTime = Time.time;
 }
  function OnTriggerEnter(hit : Collider){

 if(hit.gameObject.tag == "NewLap")
 { 
	if(started == true)
	{
		if(bestlap == 0.0)
		{
				bestlap = time;
		}
		else if(bestlap > time)
		{
			bestlap = time;
		}
	}
	
	started = true;
	StartNewLap();}
 }
 function FormatTime (time : float){
     
     var minutes : int = Mathf.Floor(time / 60.0);
     
     var seconds : int = Mathf.Floor(time - minutes * 60.0);
     
     var milliseconds = time - Mathf.Floor(time);
     
     milliseconds = Mathf.Floor(milliseconds * 1000.0);
     
     var sMinutes = "00" + minutes.ToString();
     
     sMinutes = sMinutes.Substring(sMinutes.Length-2);
     
     var sSeconds = "00" + seconds.ToString();
     
     sSeconds = sSeconds.Substring(sSeconds.Length-2);
     
     var sMilliseconds = "000" + milliseconds.ToString();
     
     sMilliseconds = sMilliseconds.Substring(sMilliseconds.Length-3);
             
     timeText = sMinutes + ":" + sSeconds + ":" + sMilliseconds;
         
     return timeText;
     
         }