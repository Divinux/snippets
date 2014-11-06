var vSpeed : int = 10;

function Start () {
	
}

function Update ()
{
	transform.Translate(Vector3.forward * Time.deltaTime * vSpeed);
}