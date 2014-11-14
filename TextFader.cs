using UnityEngine;
using System.Collections;
using System;
public class TextFader : MonoBehaviour 
{
//class that fakes a text, blends it in and then out again
//text to display
public string vText;
//style to display in
public GUISkin vSkin;

//text position
public int vX = 10;
public int vY = 40;

//fading status 0=idle 1=fading in 2 = fading oout
private int vStatus = 0;
//current alpha
private float vCurrA = 0.0F;
//string array stack
public string[] vStack;


void Update () 
{
	//check if any messages are queued up and fade em in and out
	if(vStatus != 0)
	{
		if(vStatus == 1)
		{
			vCurrA = Mathf.Lerp(vCurrA, 1.0F, Time.deltaTime*2);
			
			if(vCurrA >= 0.99)
			{
				vStatus = 2;
			}
		}
		else if(vStatus == 2)
		{
			vCurrA = Mathf.Lerp(vCurrA, 0.0F, Time.deltaTime*4);
			
			if(vCurrA <= 0.01)
			{
				vStatus = 0;
				vCurrA = 0.0F;
				if(vStack.Length != 0){
					fFollowup();
				}
			}
		}
	}
}

void OnGUI()
{
	if(vStatus != 0)
	{
		GUI.skin = vSkin;
		GUI.color = new Color(GUI.color.r,GUI.color.g, GUI.color.b, vCurrA);
		GUI.Label (new Rect (vX, vY, 300, 60), vText);
	}
}


//call this function to trigger the text
public void fFade(string t)
{

	//if its busy
	if(vStatus != 0)
	{
		//resize array
		Array.Resize(ref vStack, vStack.Length + 1);
		vStack[vStack.Length-1] = t;
	}
	else
	{
		//set string to display
		vText = t;
		//set no visibility
		vCurrA = 0.0F;
		//set status to busy
		vStatus = 1;

	}
}
//function that follows up on messages coming in when fader is busy
void fFollowup()
{
	//set text to display
	vText = vStack[0];
	//move all queued strings down
	for(int i = 0; i < vStack.Length-1; i++)
	{
		vStack[i] = vStack[i+1];
	}
	if(vStack.Length != 0){
		fFade(vText);
	}
	//resize array
	Array.Resize(ref vStack, vStack.Length - 1);
	}

}
