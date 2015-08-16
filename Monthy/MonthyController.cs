using UnityEngine;
using System.Collections;

public class MonthyController : MonoBehaviour 
{
	public GameObject Monthy1;
	public GameObject Monthy2;
	
	public GameObject Current;
	
	public string games = "1000";
	public string rooms = "3";
	public string perFrame = "10";
	
	monthy2 m2;
	monthy m1;
	
	
	void OnGUI() 
	{
		if (GUI.Button(new Rect(10, 200, 200, 30), "Start Version 1 Switching"))
		{
			MakeNew(1, games, rooms, 1);
		}
		if (GUI.Button(new Rect(10, 240, 200, 30), "Start Version 1 Not Switching"))
		{
			MakeNew(1, games, rooms, 0);
		}
		if (GUI.Button(new Rect(10, 280, 200, 30), "Start Version 2"))
		{
			MakeNew(2, games, rooms, 0);
		}
		games = GUI.TextField(new Rect(250, 205, 200, 20), games, 25);
		rooms = GUI.TextField(new Rect(250, 245, 200, 20), rooms, 25);
		perFrame = GUI.TextField(new Rect(250, 285, 200, 20), perFrame, 25);
		GUI.Label(new Rect(460, 210, 500, 20), "Games");
		GUI.Label(new Rect(460, 245, 500, 20), "Doors");
		GUI.Label(new Rect(460, 285, 500, 20), "Calculations per Frame");
	}
	
	void MakeNew(int choice, string g, string r, int b)
	{
		if(Current != null)
		{
			Destroy(Current);
		}
		if(choice == 1)
		{
			Current =  Instantiate(Monthy1, transform.position, transform.rotation) as GameObject;
			m1 = Current.GetComponent<monthy>();
			m1.gameAmount = int.Parse(g);
			m1.Doors = int.Parse(r);
			m1.pF = int.Parse(perFrame);
			if(m1.Doors <= 2)
			{
				m1.Doors = 3;
				rooms = "3";;
			}
			if(b == 1)
			{
				m1.switching = true;
			}
			else
			{
				m1.switching = false;
			}
			m1.Started = true;
		}
		else
		{
			Current =   Instantiate(Monthy2, transform.position, transform.rotation) as GameObject;
			m2 = Current.GetComponent<monthy2>();
			m2.gameAmount = int.Parse(g);
			m2.Doors = int.Parse(r);
			m2.pF = int.Parse(perFrame);
			if(m2.Doors <= 2)
			{
				m2.Doors = 3;
				rooms = "3";
			}
			m2.Started = true;
		}		
	}
}
