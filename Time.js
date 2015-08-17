//Time and calendar
static var sec : int = 0;
static var mnt : int = 0;
static var std : int = 0;
static var day : int = 1;
static var mon : int = 1;
static var jahr: int = 2000;

function Update () {
	Uhr();
	
}

function Uhr () {
	sec++;
	if(sec > 60){
		sec= 0;
		mnt++;
	}
	else if (mnt > 60) {
		mnt = 0;
		std++;
	}
	else if (std > 24) {
		std = 1;
		day++;
	}
	else if (day > 30) {
		day = 1;
		mon++;
	}
	else if (mon > 12) {
		mon = 1;
		jahr++;
	}
}

function OnGUI(){
	GUI.Label(Rect(10,10,400,30), "Date: " + day + ", " + mon + ", " + jahr + " Time:" + std + ":" + mnt + ":" + sec);
	
}

