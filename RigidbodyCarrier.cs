/**
  RigidbodyCarrier by Sascha Graeff
  www.BlackIceGames.de/development
**/

using UnityEngine;
using System.Collections;

public class RigidbodyCarrier : MonoBehaviour
{
	//How far the pick Raycast looks for an object
	const float pickDistance = 3f;
	//The Input Button used for picking objects
	const string pickButton = "Fire1";
	//How fast the objects tries to reach the target position
	const float holdPower = 20f;
	//How far the target position and the position the object is after SweepTesting
	//can be before the objetc is dropped
	const float sweepDistanceMax = 0.8f;
	//A small value. See in SweepTest what it's good for
	const float hitskin = 0.01f;
	//My transform
	private Transform me;
	//The carried Rigidbody
	private Rigidbody carried;
	//Drop object in the next FixedUpdate()
	private bool drop = false;
	
	//Offset relative to this object where the carried object should try to be
	public Vector3 offset = new Vector3(0f,-0.6f,2f);
	//If we look too far down, the object won't come with us
	public float maxXRotation = 30f;
	//A factor the objects velocity is multiplied with when it's dropped
	public float throwFactor = 0.8f;



	void Awake()
	{
		me = transform;
	}

	void Update()
	{
		//If we have no object...
		if(carried == null)
		{
			//Pick up object
			if(Input.GetButtonDown(pickButton))
			{
				RaycastHit hit;
				if(Physics.Raycast(me.position, me.forward, out hit, pickDistance))
				{
					if(hit.collider.attachedRigidbody != null)
					{
						Rigidbody found = hit.collider.attachedRigidbody;
						if(!found.isKinematic)
						{
							carried = found;
						}
					}
				}
			}
		}
		else
		{
			//Drop object
			if(Input.GetButtonDown(pickButton))
			{
				drop = true;
			}
		}
	}
	
	void FixedUpdate()
	{
		//If we have an object...
		if(carried != null)
		{
			//Ensure that our object is always kinematic as long as we hold it
			carried.isKinematic = true;
			//Get our look rotation
			Vector3 euler = me.rotation.eulerAngles;
			//Manipulate euler.x if we look down too much
			if(euler.x < 180 && euler.x > maxXRotation)
			{
				euler.x = maxXRotation;
			}
			//The position the object should try to move to
			Vector3 hold = me.position + Quaternion.Euler(euler) * offset;
			//The position the object should try to move to, smoothly
			Vector3 target = Vector3.Lerp(carried.position, hold, holdPower * Time.deltaTime);
			//The direction the object sould move along, according to target
			Vector3 direction = target - carried.position;
			//SweepTest if the object can reach target
			//We need to make a SweepTestall() because SweepTest() and multiple obstacles don't work well together
			//Look a little further so we can't get nearer to an obstace as "hitskin" meters
			RaycastHit[] hits = carried.SweepTestAll(direction, direction.magnitude + hitskin);
			//Obstacles found?
			if(hits.Length > 0)
			{
				//Get the hit with the shortest distance
				//There must be no non-kimematic rigidbody!
				//Hit cannot be null, said Unity. Well then
				RaycastHit hit = hits[0];
				bool found = false;
				float hdist = Mathf.Infinity;
				for(int i = 0; i < hits.Length; ++i)
				{
					//if((hits[i].rigidbody == null || hits[i].rigidbody.isKinematic) && hits[i].distance < hdist)
					if(hits[i].distance < hdist)
					{
						hit = hits[i];
						hdist = hit.distance;
						found = true;
					}
				}
				if(found)
				{
					//Push the other rigidbody, if there is one
					if(hit.rigidbody != null && !hit.rigidbody.isKinematic)
					{
						hit.rigidbody.AddForce((target - carried.position) * 80f);
					}
					//Set newtarget to the point as close to the target as the object can go
					//Substract hitskin from hit.distance so we can get a positive SweepTest result in the next FixedUpdate
					Vector3 newtarget = carried.position + direction.normalized * (hit.distance - hitskin);

					//Let the object slip across its obstacle
					if(Physics.Raycast(carried.position, direction, out hit, direction.magnitude * 10))
					{
						float ndistance = Vector3.Distance(newtarget, hit.point);
						Vector3 sliptarget = hit.point + hit.normal * ndistance;
						newtarget = Vector3.Lerp(newtarget, sliptarget, 0.5f);
					}

					//If the point we want the object to go and the point it can reach are too far apart, drop it
					if(Vector3.Distance(target, newtarget) > sweepDistanceMax)
					{
						drop = true;
					}
					//Update target to the new target so the object doesn't go through a wall
					target = newtarget;
				}
			}
			//Move it!
			carried.MovePosition(target);
			//Drop it?
			if(drop)
			{
				carried.isKinematic = false;
				carried.velocity *= throwFactor;
				carried = null;
				drop = false;
			}
		}
	}

	
}
