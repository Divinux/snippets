using UnityEngine;
using System.Collections;

public class test : MonoBehaviour {
public Rigidbody rb;

	// Use this for initialization
	void Start () {
	rb.constraints = RigidbodyConstraints.FreezePositionX;
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
