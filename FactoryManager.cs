using UnityEngine;
using System.Collections;
using System.Collections.Generic;
public class EconomyManager : MonoBehaviour 
{
	public List<GameObject> factories = new List<GameObject>();

	public int nextCommand = 0;
	Factory f;	
	
	void Update () 
	{
		if(factories.Count > 0)
		{
			if(nextCommand < factories.Count)
			{//Debug.Log(nextCommand);
				f = factories[nextCommand].GetComponent<Factory>();
				f.Check();
				nextCommand++;
			}
			else
			{
				//Debug.Log("resetting");
				nextCommand = 0;
			}
		}
	}
}
