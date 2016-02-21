//most basic car controller
var leftWheel : WheelCollider;
var rightWheel : WheelCollider;
var maxTorque= 260.0;

function Start ()
{
	rigidbody.centerOfMass.y = 0;
	
}

function FixedUpdate ()
{
	leftWheel.motorTorque = maxTorque * Input.GetAxis("Vertical");
	rightWheel.motorTorque = maxTorque * Input.GetAxis("Vertical");
	leftWheel.steerAngle = 10 * Input.GetAxis("Horizontal");
	rightWheel.steerAngle = 10 * Input.GetAxis("Horizontal");
	
}