using UnityEngine;
using System.Collections;

public class Die : MonoBehaviour 
{

	void Awake () 
	{
		Invoke("fDie", 2f);
	}
	
	void fDie () 
	{
		Destroy(gameObject);
	}
}
