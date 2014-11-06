var vRotor : GameObject;
var vRotorBack : GameObject;
var vRotorRPM : int = 5000;
var vPitch : float = 0;
var vAltitudelock : boolean = false;
var vMaxSpeed : int = 140;
private var newVelocity : Vector3;
private var vLockAlt : float;



function FixedUpdate ()
{
	RotorRotation();
	Controls();
	Lift();
}

// This function rotates the blades. Assign vRotor and vRotorBack and modify vRotorRPM to make it spin up when the engine is started etc.
function RotorRotation ()
{
	if(vRotor != null)
	{
		vRotor.transform.Rotate(Vector3.up * Time.deltaTime * vRotorRPM, Space.Self);
	}
	if(vRotorBack != null)
	{
		vRotorBack.transform.Rotate(Vector3.right * Time.deltaTime * vRotorRPM, Space.Self);
	}
}

//This function controls the input. Modify to make the helicopter behave differently or add AI.
function Controls ()
{
	
	//This if-statement controls the pitch of the helicopter. Modify the 1000 to make it pitch slower.
	if(Input.GetAxis("Vertical"))
	{
		if(Input.GetAxis("Vertical") > 0)
		{
			rigidbody.AddRelativeTorque(Vector3.right * 300);
		}
		if(Input.GetAxis("Vertical") < 0)
		{
			rigidbody.AddRelativeTorque(Vector3.left * 300);
		}
	}
	
	//This if-statement controls the roll of the helicopter. Modify the 200 to make it pitch slower.
	if(Input.GetAxis("Horizontal"))
	{
		if(Input.GetAxis("Horizontal") > 0)
		{
			rigidbody.AddRelativeTorque(Vector3.back * 100);
		}
		if(Input.GetAxis("Horizontal") < 0)
		{
			rigidbody.AddRelativeTorque(Vector3.forward * 100);
		}
	}
	
	//The next two if-statements modify the yaw of the helicopter. Not that the input keys are not hardcoded, you need to assign "RotateRight" and "RotateLeft" in Edit->Project Settings->Input.
	if(Input.GetButton("RotateRight"))
	{
		rigidbody.AddRelativeTorque(Vector3.up * 250);
	}
	if(Input.GetButton("RotateLeft"))
	{
		rigidbody.AddRelativeTorque(Vector3.down * 250);
	}
	
	//The next two if-statements modify the pitch that makes the helicopter rise or sink. Hovering altitude for a 1000kg rigidbody seems to be around 10 Pitch.
	if(Input.GetButton("PitchUp"))
	{
		vPitch = vPitch + 0.1;
		AltCheck();
	}
	
	//The negative pitch allows for uplift while flying upside down like so called 360° stunt helicopters.
	if(Input.GetButton("PitchDown"))
	{
		vPitch = vPitch - 0.1;
		AltCheck();
	}
	
	//This statement locks the altitude to provide a hovering mode and make the control easier.
	if(Input.GetButtonUp("AltitudeToggle"))
	{
		if(vAltitudelock == false)
		{
			//rigidbody.constraints = RigidbodyConstraints.FreezePositionY;
			vLockAlt = transform.position.y;
			vAltitudelock = true;
		}
		else
		{
			//rigidbody.constraints = RigidbodyConstraints.None;
			vAltitudelock = false;
		}
	}
	
	if(vAltitudelock == true)
	{
		if(transform.position.y > vLockAlt)
		{
			vPitch = vPitch - 0.05;
			if(vPitch < 20)
			{
				vPitch = 20;
			}
			vLockAlt = transform.position.y;
		}
		if(transform.position.y < vLockAlt)
		{
			vPitch = vPitch + 0.05;
			
			AltCheck();
			vLockAlt = transform.position.y;
		}
	}
	
	
	//This statement limits the velocity of the helicopter.
	if(rigidbody.velocity.z >= vMaxSpeed * 0.05)
	{
		rigidbody.velocity.z = vMaxSpeed * 0.05;
	}
}


//This function provides lift.
function Lift()
{
	rigidbody.AddRelativeForce(Vector3.up * vPitch * 400);
}

//This function checks if the rotor pitch is within limits.
function AltCheck()
{
	if(vPitch > 40)
	{
		vPitch = 40;
	}
	
	if(vPitch < -30)
	{
		vPitch = -30;
	}
}

//This function displays the label. You can remove it completely.
function OnGUI()
{
	 GUI.Box(Rect(5,5,400,90),"");
	GUI.Label (Rect (10, 10, 500, 20), "Pitch: W/S, Roll: A/D, Yaw: Q/E, Rotorpitch: T/G, Altitude Lock: F");
	GUI.Label (Rect (10, 30, 500, 20), "Rotorpitch: "+vPitch);
	GUI.Label (Rect (10, 50, 500, 20), "Altitude Lock: "+vAltitudelock);
	GUI.Label (Rect (10, 70, 500, 20), "Speed: "+rigidbody.velocity.z * 20);
	
}