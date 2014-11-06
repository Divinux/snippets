var vCross : Texture2D;
var inmenu : boolean;

function Update()
{
	if(Input.GetKeyDown("escape"))
	{
		if(inmenu==false)
		{
			
			Screen.showCursor=false;
			Screen.lockCursor=true;
			inmenu = true;
			
		}
		else
		{
			inmenu = false;
			Screen.showCursor=true;
			Screen.lockCursor=false;
		}
	}
}

function OnGUI ()
{
	if(inmenu == false)
	{
		if (gameObject.transform.root.tag == "Player")
		{
			GUI.Label(Rect(Screen.width / 2, Screen.height / 2, 10, 10), vCross);
		}
	}
	else
	{
		if(GUI.Button(Rect(10,Screen.height-20,60,20),"Quit"))
		{
			Application.Quit();
			//inmenu = true;
		}
	}
	
	
}

function Awake()
{
	inmenu = false;
	Screen.showCursor=false;
	Screen.lockCursor=true;
}
