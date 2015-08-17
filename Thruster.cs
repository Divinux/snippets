//thruster item
//used for rocketjumping 
using UnityEngine;
using System.Collections;

public class Thruster : MonoBehaviour 
{
public float strength;

private GameObject player;
private GameObject cam;

private bool vFired = false;
private bool vFired2 = false;
	void Awake () 
	{
		player = GameObject.FindWithTag("Player");
		cam = GameObject.FindWithTag("MainCamera");
	}
	
	void Update () 
	{
		 if (Input.GetMouseButtonDown(0))
		{
			vFired = true;
		}
		if (Input.GetMouseButtonDown(1))
		{
			vFired2 = true;
		}
	}
	
	void FixedUpdate()
	{
		if(vFired)
		{
			player.rigidbody.AddForce(cam.transform.forward * strength, ForceMode.Impulse);	
			
			vFired = false;
		}
		else if(vFired2)
		{
		player.rigidbody.AddForce(-cam.transform.forward * strength, ForceMode.Impulse);	
			
			vFired2 = false;
		}
	}
}
