using UnityEngine;
using System.Collections;
//toggler from my TD game
public class CameraToggler : MonoBehaviour 
{
	public GameObject v1;
	public GameObject v2;
	public GameObject v3;
	
	public int vCurr = 1;
	
	public float vAmount = 0.1f;
	
	public Sound vS;
	private Vector3 velocityRec = Vector3.zero;
	void Awake () 
	{
		RenderSettings.fog = false;
		vS = gameObject.GetComponent<Sound>();
		MoveTo(v1);
	}
	
	void Update () 
	{
		if(Input.GetKeyDown("c"))
		{
			vS.PlayClickY();
			Switch();
		}
		if(Input.GetAxis("Mouse ScrollWheel") < 0)
		{
			Zoom(0);
		}
		if(Input.GetAxis("Mouse ScrollWheel") > 0)
		{
			Zoom(1);
		}
	}
	void Zoom(int i)
	{
		if(i == 0)
		{
			if(v1.transform.position.y <= 40){
			v1.transform.position = new Vector3(v1.transform.position.x,v1.transform.position.y+vAmount,v1.transform.position.z);}
			if(v2.transform.localPosition.y <= 20){
			v2.transform.Translate(-Vector3.forward * vAmount, Space.Self);}
			
		}
		else
		{
			if(v1.transform.position.y >= 2){
			v1.transform.position = new Vector3(v1.transform.position.x,v1.transform.position.y-vAmount,v1.transform.position.z);}
			if(v2.transform.localPosition.y >= 2){
			v2.transform.Translate(Vector3.forward * vAmount, Space.Self);}
			
		}
	}
	public void Switch()
	{
		if(vCurr == 1)
		{
			RenderSettings.fog = true;
			
			MoveTo(v2);
			vCurr = 2;
		}
		else if(vCurr == 2)
		{
			RenderSettings.fog = true;
			MoveTo(v3);
			vCurr = 3;
		}
		else
		{
			RenderSettings.fog = false;
			MoveTo(v1);
			vCurr = 1;
		}
	}
	
	void MoveTo(GameObject a)
	{
		transform.parent = a.transform;
		StopCoroutine("MoveToCo");
		StartCoroutine("MoveToCo", a);
	}
	IEnumerator MoveToCo(GameObject b)
	{
		while(transform.position != b.transform.position || transform.rotation != b.transform.rotation)
		{
			transform.position = Vector3.SmoothDamp(transform.position, b.transform.position, ref velocityRec, 0.2f);
			
			transform.rotation =Quaternion.Slerp (transform.rotation,b.transform.rotation, 0.1f);
			yield return new WaitForSeconds(0f);
		}
	}
}
