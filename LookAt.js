var vPlayer : GameObject;

function Start () {
vPlayer = GameObject.FindGameObjectsWithTag("Player")[0];
	
}

function Update ()
{
	transform.LookAt(vPlayer.transform, Vector3.up);
}