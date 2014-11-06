var vCar : Transform;
var vFix : float;

function Start () {
	
}

function Update ()
{
	vCar = this.transform.root;
	
	vFix = vCar.transform.localEulerAngles.x;
	
	if(vFix > 180)
	{
		vFix = 360 - vFix;
		vFix = vFix * -0.25;
		gameObject.GetComponent(SmoothFollow).height = 1 + vFix;
	}
	else
	{
		vFix = vFix * 0.25;
		gameObject.GetComponent(SmoothFollow).height = 1 + vFix;
	}
	
}