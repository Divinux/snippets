using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class Building : MonoBehaviour 
{
	//distance at which objects spawn 
	public float vBuildDist = 5f;
	//tag for the position markers
	public string vTag = "handle";
	//currently selected part in the list
	//change this from wherever to have the player select an item
	public int vSelected = -1;
	//list of all prefabs
	public List<Part> Prefabs = new List<Part>();
	
	//private stuffs
	RaycastHit hit;
	GameObject Preview;
	//list of all handles the prefab has
	List<GameObject> Handles = new List<GameObject>();
	//currently active handle
	int vSelectedHandle = 0;
	//just a position holder
	Vector3 p;
	
	//a single object class, 
	//the actual part that gets instantiated,
	//and the preview model with
	[System.Serializable]
	public class Part
	{
		public GameObject Prefab;
		public GameObject Preview;
	}
	
	void Update () 
	{
		//check for player selection
		//only needed for testing, feel free to delete
		CheckSelection();
		//if any item is "active"
		if(vSelected != -1)
		{
			//check if anything was hit
			if(Physics.Raycast(Camera.main.ScreenPointToRay(new Vector3((Screen.width / 2), (Screen.height / 2), 0)), out hit, vBuildDist))
			{
				//enable preview
				EnableSelected();
				//check hit object for its tag
				if(hit.transform.tag == vTag)
				{
					//find position
					p = Handles[vSelectedHandle].transform.position - Preview.transform.position;
					//move preview into position
					Preview.transform.position = hit.transform.position - p;
				}
			}
			//if not, just spawn it at default distance
			else
			{
				//enable preview
				EnableSelected();
				Preview.transform.position = Camera.main.transform.position+(Camera.main.transform.forward*vBuildDist);
			}
			// rotating
			if(Input.GetKeyUp(KeyCode.Q))
			{
				Preview.transform.eulerAngles = new Vector3(Preview.transform.eulerAngles.x, Preview.transform.eulerAngles.y + 90, Preview.transform.eulerAngles.z);
			}
			if(Input.GetKeyUp(KeyCode.E))
			{
				Preview.transform.eulerAngles = new Vector3(Preview.transform.eulerAngles.x, Preview.transform.eulerAngles.y, Preview.transform.eulerAngles.z + 90);
			}
			// toggling handles
			if(Input.GetKeyUp(KeyCode.R))
			{
				if(Handles.Count > 0)
				{
					vSelectedHandle++;
					if(vSelectedHandle >= Handles.Count)
					{
						vSelectedHandle = 0;
					}
				}
			}
			AwaitPlacement();
		}
		else if(Preview != null)
		{
			Destroy(Preview);
			Handles.Clear();
		}
		
	}
	//waits for the placer to actually place the prefab 
	void AwaitPlacement()
	{
		if(Input.GetMouseButtonUp(0))
		{
			Instantiate(Prefabs[vSelected].Prefab, Preview.transform.position, Preview.transform.rotation);
		}
	}
	//enables the selected preview
	void EnableSelected()
	{
		if(Preview == null)
		{
			//instantiate if no preview is present
			Preview = Instantiate(Prefabs[vSelected].Preview,Camera.main.transform.position+(Camera.main.transform.forward*vBuildDist), new Quaternion(0,0,0,0)) as GameObject;
			FindHandles(Preview);
			//Pr = Preview.GetComponent<Renderer>();
		}
		else if(Preview.transform.tag != Prefabs[vSelected].Preview.transform.tag)
		{
			//if wrong preview is present, 
			//delete, then instantiate correct one
			Destroy(Preview);
			Preview = Instantiate(Prefabs[vSelected].Preview,Camera.main.transform.position+(Camera.main.transform.forward*vBuildDist), new Quaternion(0,0,0,0)) as GameObject;
			FindHandles(Preview);
			//Pr = Preview.GetComponent<Renderer>();
		}
		else
		{
			//else just move the preview
			Preview.transform.position = Camera.main.transform.position+(Camera.main.transform.forward*vBuildDist);
		}
	}
	//Finds all handles the prefab has 
	void FindHandles(GameObject g)
	{
		Handles.Clear();
		foreach(Transform c in Preview.transform)
		{
			if(c.tag == vTag)
			{
				Handles.Add(c.gameObject);
			}
		}
	}
	//PLACEHOLDER METHOD FOR SELECTING
	//REPLACE WITH WHATEVER
	//WAY YOU HAVE FOR THE PLAYER
	//TO SELECT ITEMS
	void CheckSelection()
	{
		if(Input.GetKeyDown ("1"))
		{
			if(vSelected != 0)
			{vSelected = 0;}
			else
			{vSelected = -1;}
		vSelectedHandle = 0;
		}
		else if(Input.GetKeyDown ("2"))
		{
			if(vSelected != 1)
			{vSelected = 1;}
			else
			{vSelected = -1;}
		vSelectedHandle = 0;
		}
	}
}
