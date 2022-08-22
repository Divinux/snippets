using System.Collections;
using System.Collections.Generic;
using UnityEngine;

//moves the object it is attached to in distinct steps
//a cube volume filled with points is attached to a parent object
//this script is put ion the parent obeject to create a floating preview placement grid
public class Snapping : MonoBehaviour
{
    public Transform Player;
    // Update is called once per frame
    void Update()
    {
        Vector3 currentPos = Player.position;
		currentPos.x = currentPos.x-3;
		currentPos.y = currentPos.y-3;
		currentPos.z = currentPos.z-3;
		currentPos.x = Mathf.Round(currentPos.x);
		currentPos.y = Mathf.Round(currentPos.y);
		currentPos.z = Mathf.Round(currentPos.z);
		transform.position = currentPos;
    }
}
