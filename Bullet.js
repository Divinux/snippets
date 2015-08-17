//moves an object forward
var vSpeed : int = 10;

function Update ()
{
	transform.Translate(Vector3.forward * Time.deltaTime * vSpeed);
}