using UnityEngine;
using System.Collections;

public class monthy2 : MonoBehaviour {
	
	//start toggle
	public bool Started = false;
	//calcs per frame
	public int pF;
	//random door number
	int Door = 1;
	//current game
	int gameCurrent = 0;
	//games where the contestant switched
	int gamesSwitched = 0;
	//games where the contestand didn't switch
	int gamesNotSwitched = 0;
	//finish text
	string textFinish = "";
	//amount of doors
	public int Doors = 3;
	//max amount of  games
	public int gameAmount = 10000; 
	//switch or stay
	public bool switching = false;
	//wins
	int winsBySwitch = 0;
	int winsByStay = 0;
	
	//winning door
	int doorWinning = 1;
	//chosen door
	int doorChosen = 1;
	//chosen door the second time around
	int doorChosen2 = 1;
	//opened door
	int doorOpened = 1;
	
	
	// Use this for initialization
	void Start () 
	{
		//Debug.Log("Monthy Python problem simulation v2");
		
	}
	
	void OnGUI() 
	{
		GUI.Label(new Rect(10, 10, 800, 20), "Game Number: " + gameCurrent + "/" + gameAmount);
		GUI.Label(new Rect(10, 30, 800, 20), "Switched games won: " + winsBySwitch + "/" + gamesSwitched);
		GUI.Label(new Rect(10, 70, 800, 20), "Not switched games won: " + winsByStay + "/" + gamesNotSwitched);
		GUI.Label(new Rect(10, 110, 800, 20), textFinish);
	}
	void Calculate(int n)
	{
		for(int i = 0; i<n;i++){
		//if not finished
			if(gameCurrent <= gameAmount)
			{
				//increase current game number
				gameCurrent++;
				//find winning door
				//NOTE: In Unity 4.6 the arguments are (inclusive, exclusive)
				//this was changed in Unity 5 to (inclusive, inclusive)
				doorWinning = Random.Range(0,Doors);
				//chose initial door
				doorChosen = Random.Range(0,Doors);
				//open losing door
				doorOpened = pick(doorChosen,doorWinning);
				//pick a door again, and in doing so either stay with your initial choice, or accept the switch
				doorChosen2 = pick(doorOpened);
				//check if the pick remains the same 
				//"No, I do not switch doors and stay with my initial choice"
				if(doorChosen2 == doorChosen)
				{
					gamesNotSwitched++;
					if(doorChosen2 == doorWinning)
					{
						winsByStay++;
					}
				}
				//or if it changes
				//"Yes I want to switch"
				else if(doorChosen2 != doorChosen)
				{
					gamesSwitched++;
					if(doorChosen2 == doorWinning)
					{
						winsBySwitch++;
					}
				}
			}
			else
			{
				float a = (float)winsBySwitch/(float)gamesSwitched*100;
				float b = (float)winsByStay/(float)gamesNotSwitched*100;
				textFinish = "Finished! Switchwins: " + a + "% Staywins: " + b + "%";
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
	// randomly pick a door excluding one input door
	int pick(int excludeA) 
	{
		do 
		{
			Door = Random.Range(0,Doors);
		} while (Door == excludeA);
		return Door;
	}
	
}
