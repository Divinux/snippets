using UnityEngine;
using System.Collections;

public class RacSize : MonoBehaviour {
	public float addSize;
	public Vector3 maxSize;
	public GameObject plods;
	bool enab;
	
	void Start(){
		enab = true;
	}
	
	void Update()
	{
		if(transform.localScale.x > maxSize.x && transform.localScale.y > maxSize.y && transform.localScale.z > maxSize.z){
			enab = false;
			plods.active = true;
		}
		
		if(enab){
			transform.localScale += new Vector3(Time.deltaTime*addSize,Time.deltaTime*addSize,Time.deltaTime*addSize);
		}
	}
}
