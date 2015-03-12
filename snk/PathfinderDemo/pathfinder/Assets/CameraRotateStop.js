


function Update () 
{
	//lock rotation values
	transform.eulerAngles.x = 15;
	transform.eulerAngles.y = 270;
	transform.eulerAngles.z = 0;
	//lock position
	transform.position.z = transform.parent.position.z;
}