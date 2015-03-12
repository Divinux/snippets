#pragma strict

function Start () {

}

function Update () 
{
	if(Input.GetKey("r"))
	{
	Application.LoadLevel(0);
	}
}

function OnGUI()
{
	GUI.Label (Rect (10, 10, 200, 20), "Press R To Restart");
}