using UnityEngine;
using System.Collections;

public class test : MonoBehaviour 
{

	public float x = 0f;
	public float z = 0;
	public int tester = 1;
	public int tester2 = 1;
	public float steps = 10f;
	
	public GameObject point;
	public GameObject parentpref;
	public GameObject currparent;
	
	void Update () 
	{
		
		if (Input.GetKeyDown("a")) 
		{
			currparent = Instantiate(parentpref, new Vector3(0,0,0), new Quaternion(0,0,0,0)) as GameObject;
			currparent.name = "Lerp";
			z = 0;
			x = 0f;
			StartCoroutine(lerp());
		}
		if (Input.GetKeyDown("s")) 
		{
			currparent = Instantiate(parentpref, new Vector3(0,0,0), new Quaternion(0,0,0,0)) as GameObject;
			currparent.name = "WeightedLerp";
			z = 0;
			x = 0f;
			if(tester < 3){tester = 3;}
			StartCoroutine(werp());
		}
		if (Input.GetKeyDown("d")) 
		{
			currparent = Instantiate(parentpref, new Vector3(0,0,0), new Quaternion(0,0,0,0)) as GameObject;
			currparent.name = "Cat-Rom Spline";
			z = 0;
			x = 0f;
			StartCoroutine(crom(0,10,tester,tester2));
		}
		if (Input.GetKeyDown("f")) 
		{
			currparent = Instantiate(parentpref, new Vector3(0,0,0), new Quaternion(0,0,0,0)) as GameObject;
			currparent.name = "Sine";
			z = 0;
			x = 0f;
			StartCoroutine(sin(tester,tester2));
		}
		if (Input.GetKeyDown("g")) 
		{
			currparent = Instantiate(parentpref, new Vector3(0,0,0), new Quaternion(0,0,0,0)) as GameObject;
			currparent.name = "SmoothStep";
			z = 0;
			x = 0f;
			StartCoroutine(smooth());
		}
		if (Input.GetKeyDown("h")) 
		{
			currparent = Instantiate(parentpref, new Vector3(0,0,0), new Quaternion(0,0,0,0)) as GameObject;
			currparent.name = "Hermite";
			z = 0;
			x = 0f;
			StartCoroutine(herm());
		}
		if (Input.GetKeyDown("j")) 
		{
			currparent = Instantiate(parentpref, new Vector3(0,0,0), new Quaternion(0,0,0,0)) as GameObject;
			currparent.name = "Bounce";
			z = 0;
			x = 0f;
			StartCoroutine(bounce());
		}
	}
	
	//linear interpolation 
	IEnumerator lerp()
	{
		while(x < 10)
		{
			//x = Mathfx.Weighted(x, 10, 10);
			x = Mathfx.Lerp(0,10, z);
			
			z += 1f/steps;
			GameObject a = Instantiate(point, new Vector3(z*10,x,0),transform.rotation) as GameObject;
			a.transform.parent = currparent.transform;
			yield return null;
		}
		
	}
	//weighted interpolation 
	IEnumerator werp()
	{
		while(x < 9)
		{
			x = Mathfx.Weighted(x, 10, tester);
			//x = Mathfx.Lerp(0, 10, z);
			
			z += 1f/steps;
			GameObject a = Instantiate(point, new Vector3(z*10,x,0),transform.rotation) as GameObject;
			a.transform.parent = currparent.transform;
			yield return null;
		}
		
	}
	IEnumerator crom(int from, int to, int Q, int T)
	{
		for (int i = 0; i <= steps; i++)
		{
			
			x = Mathfx.Crom(from, to, z, Q, T);
			GameObject a = Instantiate(point, new Vector3(z*10,x,0),transform.rotation) as GameObject;
			a.transform.parent = currparent.transform;
			z += 1f/steps;
			yield return new WaitForSeconds(0);
		} 
	}
	IEnumerator sin(int amp, int sp)
	{
		for (int i = 0; i <= steps; i++)
		{
			
			x = Mathfx.Sine(amp, sp, z);
			GameObject a = Instantiate(point, new Vector3(z*10,x,0),transform.rotation) as GameObject;
			a.transform.parent = currparent.transform;
			z += 1f/steps;
			yield return new WaitForSeconds(0);
		} 
	}
	IEnumerator smooth()
	{
		for (int i = 0; i <= steps; i++)
		{
			
			x = Mathfx.SmoothStep(z, 0, tester);
			GameObject a = Instantiate(point, new Vector3(z*10,x,0),transform.rotation) as GameObject;
			a.transform.parent = currparent.transform;
			z += 1f/steps;
			yield return new WaitForSeconds(0);
		} 
	}
	IEnumerator herm()
	{
		for (int i = 0; i <= steps; i++)
		{
			
			x = Mathfx.Hermite(0, 10, z);
			GameObject a = Instantiate(point, new Vector3(z*10,x,0),transform.rotation) as GameObject;
			a.transform.parent = currparent.transform;
			z += 1f/steps;
			yield return new WaitForSeconds(0);
		} 
	}
	IEnumerator bounce()
	{
		for (int i = 0; i <= steps; i++)
		{
			
			x = Mathfx.Bounce(z, tester);
			GameObject a = Instantiate(point, new Vector3(z*10,x*10,0),transform.rotation) as GameObject;
			a.transform.parent = currparent.transform;
			z += 1f/steps;
			yield return new WaitForSeconds(0);
		} 
	}

}
