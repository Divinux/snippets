using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class ModularConstruction : MonoBehaviour 
{
	public float Range = 50f;
	public float HoverDist = 10f;
	public string Tag = "handle";
	public int Selected = -1;
	public List<Part> Prefabs = new List<Part>();
	RaycastHit hit;
	GameObject Preview;
	List<GameObject> Handles = new List<GameObject>();
	int SelectedHandle = 0;
	Vector3 p;
	[System.Serializable]
	public class Part
	{
		public GameObject Prefab;
		public GameObject Preview;
	}
	
	void Update () 
	{
		CheckSelection();
		if(Selected != -1)
		{
			if(Physics.Raycast(Camera.main.ScreenPointToRay(new Vector3((Screen.width / 2), (Screen.height / 2), 0)), out hit, Range))
			{
				EnableSelected();
				if(hit.transform.tag == Tag)
				{
					p = Handles[SelectedHandle].transform.position - Preview.transform.position;
					Preview.transform.position = hit.transform.position - p;
				}
			}
			else
			{
				EnableSelected();
				Preview.transform.position = Camera.main.transform.position+(Camera.main.transform.forward*HoverDist);
			}
			AwaitRotation();
			AwaitHandleSwitch();
			AwaitPlacement();
		}
		else if(Preview != null)
		{
			Destroy(Preview);
			Handles.Clear();
		}
		
	}
	void EnableSelected()
	{
		if(Preview == null)
		{
			Preview = Instantiate(Prefabs[Selected].Preview,Camera.main.transform.position+(Camera.main.transform.forward*HoverDist), new Quaternion(0,0,0,0)) as GameObject;
			FindHandles(Preview);
		}
		else if(Preview.transform.tag != Prefabs[Selected].Preview.transform.tag)
		{
			Destroy(Preview);
			Preview = Instantiate(Prefabs[Selected].Preview,Camera.main.transform.position+(Camera.main.transform.forward*HoverDist), new Quaternion(0,0,0,0)) as GameObject;
			FindHandles(Preview);
		}
		else
		{
			Preview.transform.position = Camera.main.transform.position+(Camera.main.transform.forward*HoverDist);
		}
	}
	void AwaitPlacement()
	{
		if(Input.GetMouseButtonUp(0))
		{
			Instantiate(Prefabs[Selected].Prefab, Preview.transform.position, Preview.transform.rotation);
		}
	}
	void AwaitRotation()
	{
		if(Input.GetKeyUp(KeyCode.Q))
		{
			Preview.transform.Rotate(90,0,0,Space.World);
		}
		if(Input.GetKeyUp(KeyCode.E))
		{
			Preview.transform.Rotate(0,90,0,Space.World);
		}
		if(Input.GetKeyUp(KeyCode.R))
		{
			Preview.transform.Rotate(0,0,90,Space.World);
		}
	}
	void AwaitHandleSwitch()
	{
		if(Input.GetKeyUp(KeyCode.T))
		{
			if(Handles.Count > 0)
			{
				SelectedHandle++;
				if(SelectedHandle >= Handles.Count)
				{
					SelectedHandle = 0;
				}
			}
		}
	}
	void FindHandles(GameObject g)
	{
		Handles.Clear();
		foreach(Transform c in Preview.transform)
		{
			if(c.tag == Tag)
			{
				Handles.Add(c.gameObject);
			}
		}
	}
	void CheckSelection()
	{
		if(Input.GetKeyDown ("1"))
		{
			if(Selected != 0)
			{Selected = 0;}
			else
			{Selected = -1;}
			SelectedHandle = 0;
		}
		else if(Input.GetKeyDown ("2"))
		{
			if(Selected != 1)
			{Selected = 1;}
			else
			{Selected = -1;}
			SelectedHandle = 0;
		}
		else if(Input.GetKeyDown ("3"))
		{
			if(Selected != 2)
			{Selected = 2;}
			else
			{Selected = -1;}
			SelectedHandle = 0;
		}
		else if(Input.GetKeyDown ("4"))
		{
			if(Selected != 3)
			{Selected = 3;}
			else
			{Selected = -1;}
			SelectedHandle = 0;
		}
	}
}
