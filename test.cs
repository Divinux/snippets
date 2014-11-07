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
	
	void Update () 
	{
		if (Input.GetKeyDown("f")) 
		{
			z = 0;
			StartCoroutine(sin(tester,tester2));
		}
		if (Input.GetKeyDown("g")) 
		{
			z = 0;
			StartCoroutine(lerp2());
		}
		if (Input.GetKeyDown("h")) 
		{
			z = 0;
			StartCoroutine(herp(0,10,tester,tester2));
		}
	}
	
	//linear interpolation 
	IEnumerator lerp2()
	{
	while(x < 10)
	{
	//x = Mathfx.Weighted(x, 10, 10);
	x = Mathfx.Lerp(0, 10, z);
	
	z += 1f/steps;
	Instantiate(point, new Vector3(z*10,x,0),transform.rotation);
	yield return null;
	}
	
	}
	//linear interpolation 
	IEnumerator lerp()
	{
	while(x < 10)
	{
	x = Mathfx.Weighted(x, 10, tester);
	//x = Mathfx.Lerp(0, 10, z);
	
	z += 1f/steps;
	Instantiate(point, new Vector3(z*10,x,0),transform.rotation);
	yield return null;
	}
	
	}
	IEnumerator herp(int from, int to, int Q, int T)
	{
		for (int i = 0; i <= steps; i++)
			{
				
				x = Mathfx.Crom(from, to, z, Q, T);
				Instantiate(point, new Vector3(z*10,x,0),transform.rotation);
				z += 1f/steps;
				yield return new WaitForSeconds(0);
			} 
	}
	IEnumerator sin(int amp, int sp)
	{
		for (int i = 0; i <= steps; i++)
			{
				
				x = Mathfx.Sine(amp, sp, z);
				Instantiate(point, new Vector3(z*10,x,0),transform.rotation);
				z += 1f/steps;
				yield return new WaitForSeconds(0);
			} 
	}

}
