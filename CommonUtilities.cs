using UnityEngine;
using System.Collections;

public class CommonUtilities : MonoBehaviour 
{

	public Camera cam;
	void Start () 
	{
		cam = GetComponent<Camera>();
		cam.layerCullSpherical = true;
		float[] distances = new float[32];
		distances[9] = 111;
		cam.layerCullDistances = distances;
	}
	
	
}
