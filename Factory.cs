using UnityEngine;
using System.Collections;

public class Factory : MonoBehaviour {

	public int respawnTime = 50;
	int respawnCounter;
	
	
	void Start () 
	{
		respawnCounter = respawnTime;
		//do work
	}
	
	public void Check()
	{
		if(respawnCounter <= 0)
		{
			//do work
			respawnCounter = respawnTime;
			
		}
		else
		{
			respawnCounter--;
		}
	}
}
