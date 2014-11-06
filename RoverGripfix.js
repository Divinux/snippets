var car : GameObject;

function Start ()
{
	yield WaitForSeconds (1);
	car.GetComponent(CarController).enabled = true;
	//yield WaitForSeconds (1);
	car.GetComponent(CarController).enabled = false;
}

function Update () {
	
}