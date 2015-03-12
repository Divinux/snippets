
var vTarget : GameObject;
var vAi : GameObject;
var vC : Component;

vC = vAi.GetComponent(AI);
function Start () {

}

function Update () 
{
	if(Input.GetMouseButton(0))
	{
		print("lel");
		vC.fMoveOrder(vTarget);
	}
}

