using UnityEngine;
using System.Collections;

public class RemoveChildren : MonoBehaviour 
{

	//removes all children
	void Remove (GameObject a) 
	{
	foreach (Transform child in a.transform) 
	{
     GameObject.Destroy(child.gameObject);
 }
	}
	
}
