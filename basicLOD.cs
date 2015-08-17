using UnityEngine;
using System.Collections;

//basic LOD system that enables and disables two sets of meshes (low and highpoly) 
//based on distance to the player
public class LOD : MonoBehaviour 
{
	//array of high poly gameobjects
	public GameObject[] meshes;
	//array of low poly gameobjects
	public GameObject[] meshesLow;
	//distance at which the LOD triggers
	public float maxDist = 10.0f;
	
	private float dist;
	private bool highpoly = true;
	private GameObject player;
	

	void Awake () 
	{
		player = GameObject.FindWithTag("Player");
		 InvokeRepeating("LODCheck", 1F, 1F);
	}
	
	void LODCheck() 
	{
		if(player != null)
		{
			dist = Vector3.Distance(player.transform.position, transform.position);
			//if player is far, disable high poly
			if(dist >= maxDist)
			{
				//if already disabled
				if(highpoly == true)
				{
					//do nothing
				}
				else
				{
					//disable high poly
					disable();
					highpoly = !highpoly;
				}
			}
			//else, enable highpoly
			else
			{	
				//if  not already  enabled
				if(highpoly == true)
				{
					enable();
					highpoly = !highpoly;
				}
			}
		}
	}
	//disables the highpoly
	void disable()
	{
		if(meshes.Length > 0)
		{
			foreach(GameObject a in meshes)
			{
				a.SetActive (false);
			}
		}
		if(meshesLow.Length > 0)
		{
			foreach(GameObject c in meshesLow)
			{
				c.SetActive (true);
			}
		}
	}
	//enables the highpoly
	void enable()
	{
		if(meshes.Length > 0)
		{
			foreach(GameObject b in meshes)
			{
				b.SetActive (true);
			}
		}
		if(meshesLow.Length > 0)
		{
			foreach(GameObject d in meshesLow)
			{
				d.SetActive (true);
			}
		}
	}
}
