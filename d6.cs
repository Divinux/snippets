using UnityEngine;
using System.Collections;

public class d6 : MonoBehaviour 
{
	public int side = 0;
	
	int CalcSideUp() 
	{
		float dotFwd = Vector3.Dot(transform.forward, Vector3.up);
		if (dotFwd > 0.99f) return 5;
		if (dotFwd < -0.99f) return 2;
		float dotRight = Vector3.Dot(transform.right, Vector3.up);
		if (dotRight > 0.99f) return 4;
		if (dotRight < -0.99f) return 3;
		float dotUp = Vector3.Dot(transform.up, Vector3.up);
		if (dotUp > 0.99f) return 6;
		if (dotUp < -0.99f) return 1;
		return 0;
	}
	void Update() 
	{
		side = CalcSideUp();
		
		//if (side > 0) Debug.Log("Side = " + side);
	}
}
