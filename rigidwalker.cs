using UnityEngine;
using System.Collections;
[RequireComponent(typeof(Rigidbody),typeof(CapsuleCollider))]
public class rigidwalker : MonoBehaviour 
{	
		
		
	public float walkSpeed = 2.0F;
		
	public float jumpHeight = 2.0F;
		
	public float gravity = 10.0F;
		
	public float slopeAngle = 0.85F;
		
		
		private bool onGround = false;
		
	private Vector3 velDesired = Vector3.zero;
		
	private Vector3 velCurrent = Vector3.zero;
		
	private Vector3 velDifference = Vector3.zero;
		
	private float velJump;
		
	private static float speed = 0.0F;
		
		
		private float collisionAngle = 0.0F;
		
		
		void Awake () {
		
		
		rigidbody.freezeRotation = true;
		
		
		rigidbody.useGravity = false;
		
		
		rigidbody.isKinematic = false;
		
		
		velJump = Mathf.Sqrt(2.0F * jumpHeight * gravity);
		
		
	}
		
		
		void FixedUpdate () {
		
		
		//Only move if on a solid ground
		
		
		if (onGround && collisionAngle > slopeAngle) {
			
			
			//Get desired velocity
			
			
			velDesired = new Vector3( Input.GetAxis("Horizontal"), 0.0F, Input.GetAxis("Vertical") );
			
			
			velDesired = transform.TransformDirection(velDesired);
			
			
			speed = walkSpeed * ( bool2Int( Input.GetKey(KeyCode.LeftShift) )+1 );
			
			
			velDesired *= speed;
			
			
			//Get current velocity
			
			
			velCurrent = rigidbody.velocity;
			
			
			//Get the difference in between
			
			
			velDifference = velDesired - velCurrent;
			
			
			velDifference.y = 0.0F;
			
			
			//Apply the difference to body
			
			
			rigidbody.AddForce(velDifference, ForceMode.VelocityChange);
			
			
			//Get if want to jump
			
			
			
			
			
		}
		
		
		else {
			
			
			rigidbody.AddForce( new Vector3(0.0F, -gravity * rigidbody.mass, 0.0F) );
			
			
		}
		
		
		if ( Input.GetButton("Jump") ) {
			
			
			//float velJump = Mathf.Sqrt(2.0F * jumpHeight * gravity);
			
			
			velCurrent = rigidbody.velocity;
			
			
			rigidbody.velocity = new Vector3(velCurrent.x, velJump, velCurrent.z);
			
			
			//onGround = false;
			
			
		}
		
		
	}
		
		
		void OnCollisionStay (Collision collision) {
		
		
		//onGround = true;
		
		
		foreach (ContactPoint contact in collision.contacts) {
			
			
			if (contact.point.y < transform.position.y - 0.9F) {
				
				
				onGround = true;
				
				
				collisionAngle = Vector3.Dot(contact.normal, Vector3.up);
				
				
				//Debug.DrawRay(contact.point, contact.normal, Color.white);
				
				
			}
			
			
		}
		
		
	}
		
		
		void OnCollisionExit (Collision collision) {
		
		
		onGround = false;
		
		
	}
		
		
		void OnGUI() {
		
		
		GUI.Label (new Rect(0, 0, 100, 20), onGround.ToString());
		
		
		GUI.Label (new Rect(0, 20, 100, 20), collisionAngle.ToString());
		
		
		GUI.Label (new Rect(0, 40, 100, 20), slopeAngle.ToString());
		
		
	}
		
		
		private int bool2Int(bool b) {
		
		
		return b ? 1 : 0;
		
		
	}
		
}