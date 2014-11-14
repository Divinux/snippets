
//very basic rigidbody controller
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
	//jumpvelocity
	private float velJump;
	//current direction	
	private Vector3 velCurrent = Vector3.zero;
	//drag while walking	
	private float drag = 5F;

	void Awake () 
	{
		rigidbody.freezeRotation = true;		
		rigidbody.useGravity = false;		
		rigidbody.isKinematic = false;		
		velJump = Mathf.Sqrt(2.0F * jumpHeight * gravity);	
		drag = rigidbody.drag;
	}
	
	void Update()
	{
		if ( Input.GetButtonDown("Jump") && onGround ) 
		{
			vJumped = true;
		}
		
	}
	
	void FixedUpdate () 
	{
		fGroundCheck();
		velCurrent = rigidbody.velocity;
		if( !onGround)
		{
			rigidbody.drag = 1F;
			fMove(0.5F);
		}
		else
		{
		
			rigidbody.drag = drag;
			fMove(1F);
		}
		
		rigidbody.AddForce( new Vector3(0.0F, -gravity * rigidbody.mass, 0.0F) );
		
		if ( vJumped && onGround) 
		{			
			velJump = Mathf.Sqrt(2.0F * jumpHeight * gravity);			
			
			rigidbody.velocity= new Vector3(velCurrent.x, velCurrent.y + velJump, velCurrent.z);			
			vJumped = false;			
		}
		
	}
	
	void fMove(float a)
	{
		if(Input.GetAxis("Horizontal") != 0F || Input.GetAxis("Vertical") != 0F)
			{
				Vector3 t = transform.TransformDirection(new Vector3(Input.GetAxis("Horizontal") * walkSpeed * a,velCurrent.y,Input.GetAxis("Vertical") * walkSpeed * a));
				rigidbody.AddForce(t/*, ForceMode.Impulse*/);	
				//  rigidbody.velocity = transform.TransformDirection(new Vector3(Input.GetAxis("Horizontal") * walkSpeed,velCurrent.y,Input.GetAxis("Vertical") * walkSpeed));
			}
	}
	
	void fGroundCheck()
	{
		float i = ( (collider as CapsuleCollider).height/2)+ (collider as CapsuleCollider).radius;
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
