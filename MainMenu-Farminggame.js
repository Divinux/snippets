var vTexture : Texture2D;
var vMenuTex : Texture2D;
var vInstTex : Texture2D;

var bNew : Texture2D;
var bInstructions : Texture2D;
var bLoad : Texture2D;
var bMute : Texture2D;


function Awake()
{
vTexture = vMenuTex;
}
function OnGUI () 
{
	GUI.DrawTexture(Rect(0,0,Screen.width,Screen.height),vTexture, ScaleMode.StretchToFill, false);
	if(GUI.Button(Rect(10,Screen.height-90,200,75),bNew, "label"))
	{
		Application.LoadLevel (1);
	}
	if(GUI.Button(Rect(220,Screen.height-90,200,75),bLoad, "label"))
	{
		Application.LoadLevel (1);
	}
	if(GUI.Button(Rect(430,Screen.height-90,200,75),bInstructions, "label"))
	{
		vTexture = vInstTex;
	}
	if(GUI.Button(Rect(640,Screen.height-90,200,75),bMute, "label"))
	{
		AudioListener.pause = !AudioListener.pause;
	}

	
}