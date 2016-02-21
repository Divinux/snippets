using UnityEngine;
using System.Collections;

public class CursorLocker : MonoBehaviour 
{
	CursorLockMode wantedMode;
	// Apply requested cursor state
	void SetCursorState ()
	{
		Cursor.lockState = wantedMode;
		// Hide cursor when locking
		Cursor.visible = (CursorLockMode.Locked != wantedMode);
	}
	
	// Update is called once per frame
	void Update () 
	{
		if (Input.GetKeyDown (KeyCode.Escape))
		{
			wantedMode = CursorLockMode.None;
		}
		if (Input.GetMouseButtonDown(0))
		{
			wantedMode = CursorLockMode.Locked;
		}
		SetCursorState ();
	}
}
