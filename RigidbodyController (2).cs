
//very basic rigidbody controller
//look direction based jumping
using UnityEngine;
using System.Collections;

[RequireComponent(typeof(Rigidbody),typeof(CapsuleCollider))]
public class RigidbodyController : MonoBehaviour 
{

	//character speed
	public float walkSpeed = 2.0F;
	//jump height 	
	public float jumpHeight = 2.0F;
	//grvity	
	public float gravity = 10.0F;
	//player grounded	
	public bool onGround = false;
	//player pressed jump
	public bool vJumped = false;
	//current direction	
	private Vector3 velCurrent = Vector3.zero;
	//drag while walking	
	private float drag = 5F;
	/////////////////////trail stuff. doesnt belong to the actual controller
	//current trail object
	public GameObject Trail;
	//trail prefab
	public GameObject TrailPref;
	//trail position
	public GameObject TrailHolder;
	public GameObject Cam;
	Rigidbody rb;
	CapsuleCollider col;

	void Awake () 
	{
		Cam = GameObject.FindWithTag("MainCamera");
		col = GetComponent<Collider>() as CapsuleCollider;
		rb = GetComponent<Rigidbody>();
		rb.freezeRotation = true;		
		rb.useGravity = false;		
		rb.isKinematic = false;		
		drag = rb.drag;
	}
	
	void Update()
	{
		if (Input.GetButtonDown("Jump")) 
		{
			vJumped = true;
		}
	}
	
	void FixedUpdate () 
	{
		fGroundCheck();
		velCurrent = rb.velocity;
		if( !onGround)
		{
			rb.drag = 1F;
			fMove(0.3F);
		}
		else
		{
		rb.drag = drag;
			fMove(1F);
		}
		
		rb.AddForce( new Vector3(0.0F, -gravity * rb.mass, 0.0F) );
		
		if (vJumped) 
		{			
			rb.AddForce(Cam.transform.forward * jumpHeight, ForceMode.Impulse);
			vJumped = false;			
		}
	}
	
	void fMove(float a)
	{
		if(Input.GetAxis("Horizontal") != 0F || Input.GetAxis("Vertical") != 0F)
			{
				//actual movement
				Vector3 t = transform.TransformDirection(new Vector3(Input.GetAxis("Horizontal") * walkSpeed * a,velCurrent.y,Input.GetAxis("Vertical") * walkSpeed * a));
				rb.AddForce(t);	
			}
	}
	
	void fGroundCheck()
	{
		float i = ( col.height/2)+ col.radius;
		if (Physics.Raycast(transform.position, Vector3.down, i))
		{
			onGround = true;
		}
		else
		{
			onGround = false;
		}
	}
}
