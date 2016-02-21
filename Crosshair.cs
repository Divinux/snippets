using UnityEngine;
using System.Collections;

public class Crosshair : MonoBehaviour 
{

public string reticleName = "Default";
public Texture2D[] reticleTexture;
public string[] tags = {"Default Reticle", "Enemy"};
public float minSize = 32;
public float maxSize = 96;
public float maxDistance = 20;
public bool  visible = true;

private RaycastHit hit;
private Rect rectangle;
private Texture2D currentTexture;
private int screenHeight;
private int screenWidth;

public string  GetName (){
	return reticleName;
}

void  Start (){
screenHeight = Screen.height;
screenWidth = Screen.width;
rectangle = new Rect(screenWidth/2,screenHeight/2,minSize,minSize);//Sets draw location for reticle
}

void  Update (){
	screenWidth = Screen.width;
	screenHeight = Screen.height;
	Ray ray = Camera.main.ScreenPointToRay(new Vector3(screenWidth/2,screenHeight/2)); //Checks center of screen for raycast.
	if (Physics.Raycast(ray,out hit,  maxDistance)) //Runs check to see if there is a raycast collision within our maximum distance.
	{
		currentTexture = reticleTexture[0]; //Resets reticle in case there is no collision with a tagged object
		int i= 0;
		for(i = 0; i < tags.Length; i++)
		{
			if(hit.collider.tag == tags[i]) 	//Dynamically checks for added tags and sets the reticle if it finds that tag collided
			{
				currentTexture = reticleTexture[i];			
			}
		}
		
		rectangle.height = Map(hit.distance, 0f, maxDistance, maxSize, minSize);
rectangle.width = rectangle.height;		//this is a maping system to resize values to a different size. 5 out 10 would be resized to 50 out of 100 if it were map(5, 0, 10, 0, 100);
														//Without the above line, our reticle wouldn't resize hardly ever, and it also only scales the size between max and min value. Max is first otherwise the reticle would get larger with the further distance.
		if(rectangle.width < minSize)
		{
			rectangle.width = rectangle.height = minSize; //if distance draws it smaller then our minimum size, then resize it to minimum
		}
		if(rectangle.width > maxSize)
		{
			rectangle.width = rectangle.height = maxSize; //if distance draws it larger then our maximum size, then resize it to maximum
		}
	}else{
		rectangle.width = rectangle.height = minSize; //if no collision within the maximum distance is found then we simply draw the smallest size.
		currentTexture = reticleTexture[0];
	}
	rectangle.x = screenWidth/2 - rectangle.width/2; //These two lines change the position of the reticle to be based on the center of the texture rather then the top left.
	rectangle.y = screenHeight/2 - rectangle.height/2; //They are always needed, so it's outside of the if statements above.
} 

void  OnGUI (){
	if(visible)
	{
		GUI.DrawTexture(rectangle, currentTexture);
	}
}

float  Map ( float value ,   float fromLow ,   float fromHigh ,   float toLow ,   float toHigh  ){
	   return toLow + (toHigh - toLow) * ((value - fromLow) / (fromHigh - fromLow));
}
}