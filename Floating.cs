using UnityEngine;
using System.Collections;

//makes an object gently float up and down. 
//requires mathfx
public class Floating : MonoBehaviour 
{
	public GameObject vTarget;
	public float value = 0F;
	public float Test = 0F;
	public float vTime = 0F;
	void Awake()
	{
		if(vTarget == null)
		{
			vTarget = gameObject;
		}
	}
	void FixedUpdate () 
	{vTime = Time.time;
		value = Mathfx.Sine(0.07F, 8F, vTime);
		value *= 0.1F;
		vTarget.transform.position = new Vector3(vTarget.transform.position.x,vTarget.transform.position.y + value,vTarget.transform.position.z);

	}
}
