using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class d20 : MonoBehaviour 
{

	public List<GameObject> sides = new List<GameObject>();
	public int number = 0;
	
	bool _moving;
	float highestY=-1000000f;
	
	void Start () 
	{
		_moving = true;
		StartCoroutine (WaitForStop());
	}
	
	
	IEnumerator WaitForStop() 
	{
		while(_moving) 
		{
			yield return new WaitForSeconds(0.1f);
			if (GetComponent<Rigidbody>().velocity.sqrMagnitude < 0.01f) 
			{
				FindNumber();
				_moving = false;
			}

		}
	}
	
	void FindNumber()
	{
		highestY = -100000.0f;
		for(int i = 0; i < sides.Count; ++i)
		{
			if (sides[i].transform.position.y > highestY) 
			{	highestY = sides[i].transform.position.y;
				number = i+1;
			}
		}
	}
}
