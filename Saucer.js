//UFO control script

var saucer : GameObject;
var hoverpower : int = 100;
var hoverheight : int = 4;

function Start () {
	hoverheight = 4;
}

function Update ()
{
	var dwn = saucer.transform.TransformDirection (-Vector3.up);
	if (Physics.Raycast (transform.position, dwn, hoverheight))
	{
		rigidbody.AddForce (Vector3.up * hoverpower * 700);
	}
	
	if(Input.GetButton("f"))
	{
		hoverheight ++;
	}
	
	if(Input.GetButton("g"))
	{
		hoverheight --;
		if (hoverheight< 4)
		{
			hoverheight = 4;
		}
	}
}

function FixedUpdate ()
{
	
	
	// Get the input and set variables for it
	var horizontal = Input.GetAxis("Horizontal");
	var vertical = Input.GetAxis("Vertical");
	
	if(rigidbody.velocity.magnitude < 200)
	{
		rigidbody.AddRelativeForce (Vector3.forward * vertical * 10000);
		rigidbody.AddTorque (Vector3.up * horizontal * 10000);
	}
	
	
}
