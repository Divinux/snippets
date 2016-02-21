using UnityEngine;
using System.Collections;
//simple fishing line script
//using a line renderer
//attach to fishing pole
public class Line : MonoBehaviour {
	
	//target object = swimmer
	public GameObject vTarget;
	//how many pieces the line uses
	public int vSteps = 10;
	//width of the line
	public float vWidth = 0.1f;
	//line material
	public Material vMaterial;
	
	 //references for tight and relaxed states
	public Vector2 vRelaxed = new Vector2(-3f,0f);
	public Vector2 vTight = new Vector2(-1f,2f);
	//actual line tension
	Vector2 vCurvature = new Vector2(-3f,0f);
	//linerenderer
	LineRenderer lr; 
	//vector used for calculations
	Vector3 calc = new Vector3(0,0,0);
	//float used for calculations
	float f = 0f;
	//coroutine timer
	int loopCount = 0;
	
	void Start () 
	{
		//get linerenderer component
	lr = gameObject.GetComponent<LineRenderer>();
	//if there is none, make one
	if(lr == null)
	{
		lr = gameObject.AddComponent<LineRenderer>();
		//assign a new material if there is none
		if(vMaterial == null)
		{
		lr.material = new Material(Shader.Find("Particles/~Additive-Multiply"));
		}
		else
		{
			lr.material = vMaterial;
		}
		
	}
	//make sure the line has at least 3 pieces
	if(vSteps < 3){vSteps = 3;}
	//set vert amount and width
	lr.SetVertexCount(vSteps);
	lr.SetWidth(vWidth, vWidth);
	lr.useWorldSpace = true;
	}
	
	void Update()
	{
		Calculate();
	}
	//calculates positions of all pieces
	void Calculate () 
	{
		//set all verts
		for(int i = 0; i < vSteps; i++)
		{
			f = (float)i/vSteps;
			calc = Vector3.Lerp(gameObject.transform.position, vTarget.transform.position, f);
			calc.y = Crom(gameObject.transform.position.y, vTarget.transform.position.y, f, vCurvature.x, vCurvature.y);
			lr.SetPosition(i, calc);
		}
		//set final vert
		lr.SetVertexCount(vSteps+1);
		lr.SetPosition(vSteps, vTarget.transform.position);
	}
	//tightens the line
	   [ContextMenu ("tighten")]
	public void Tighten()
	{
		StopAllCoroutines();
		loopCount = 0;
		
		StartCoroutine(vT());
	}
	//loosens the line
	   [ContextMenu ("loosen")]
	public void Loosen()
	{
		StopAllCoroutines();
		loopCount = 0;
		
		StartCoroutine(vL());
	}
	//actual coroutines
	IEnumerator vT()
	{
		while(vCurvature.x != vTight.x && loopCount < 100)
		{
			vCurvature = Vector2.Lerp(vCurvature, vTight, Time.deltaTime*loopCount);
			loopCount++;
			yield return null;
		}
	}
	IEnumerator vL()
	{
		while(vCurvature.x != vRelaxed.x && loopCount < 100)
		{
			vCurvature = Vector2.Lerp(vCurvature, vRelaxed, Time.deltaTime*loopCount);
			loopCount++;
			yield return null;
		}
	}
	
	//catmull rom function
	float Crom(float from, float to, float value, float Q, float T)
	{

		value = catmullrom(value, Q, 0, 1, T);
		return (to * value) + (from * (1 - value));
	}
	float catmullrom(float t, float p0, float p1, float p2, float p3)
	{

		return 0.5f * ((2 * p1) +
		(-p0 + p2) * t +
		(2 * p0 - 5 * p1 + 4 * p2 - p3) * t * t +
		(-p0 + 3 * p1 - 3 * p2 + p3) * t * t * t);
	}
}
