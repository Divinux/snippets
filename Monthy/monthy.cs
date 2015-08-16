using UnityEngine;
using System.Collections;

public class monthy : MonoBehaviour {
	//start toggle
	public bool Started = false;
	//calcs per frame
	public int pF;
	//random door number
	int Door = 1;
	//current game
	int gameCurrent = 0;
	//switching text
	string textSwitch = "";
	//finish text
	string textFinish = "";
	//door amount
	public int Doors = 3;
	//max amount of  games
	public int gameAmount = 10000; 
	//switch or stay
	public bool switching = false;
	//wins
	int wins = 0;
	
	//winning door
	int doorWinning = 1;
	//chosen door
	int doorChosen = 1;
	//opened door
	int doorOpened = 1;
	//other still closed door
	int doorClosed = 1;
	
	
	void OnGUI() 
	{
		//set text 
		if(switching)
		{
			textSwitch = "switching";
		}
		else
		{
			textSwitch = "not switching";
		}
		
		GUI.Label(new Rect(10, 10, 800, 20), "Game Number: " + gameCurrent + "/" + gameAmount);
		GUI.Label(new Rect(10, 30, 800, 20), textSwitch);
		GUI.Label(new Rect(10, 50, 800, 20), "Wins so far: " + wins);
		GUI.Label(new Rect(10, 70, 800, 20), textFinish);
	}
	void Calculate(int n)
	{
		for(int i = 0; i<n; i++){
		//if not finished
			if(gameCurrent <= gameAmount)
			{
				//increase current game number
				gameCurrent++;
				//find winning door
				//NOTE: In Unity 4.6 the arguments are (inclusive, exclusive)
				//this was changed in Unity 5 to (inclusive, inclusive)
				doorWinning = Random.Range(0, Doors);
				//chose initial door
				doorChosen = Random.Range(0,Doors);
				//open losing door
				doorOpened = pick(doorChosen,doorWinning);
				//either switch the door, or dont
				if(switching)
				{
					//pick the door that is not opened or already chosen to make a switch
					doorChosen = pick(doorOpened,doorChosen);
				}
				else
				{
					//find the door that is closed
					//this is the same thing as switchng the door,
					//but without actually making it the chosen door
					doorClosed = pick(doorOpened,doorChosen);
					//pick the door that is not opened or closed to choose the same door you had already
					doorChosen = pick(doorOpened,doorClosed);
				}
				if(doorChosen == doorWinning)
				{
					wins++;
					
				}
				//Debug.Log("Winning"+doorWinning+"chosen"+doorChosen+"opened"+doorOpened);
				
			}
			else
			{
				float a = (float)wins/(float)gameAmount*100;
				textFinish = "Finished! " + wins + " wins while " + textSwitch + ". Percentage: " + a + "%";
		}
		}
	}
	void Update()
	{
		if(Started)
		{
			Calculate(pF);
		}
	}
	// randomly pick a door excluding input doors
	int pick(int excludeA,int excludeB) 
	{
		
		do 
		{
			Door = Random.Range(0,Doors);
		} while (Door == excludeA || Door == excludeB);
		return Door;
	}
	
}
