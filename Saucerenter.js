//UFO enter script
var insauc : boolean = false;
var playercam : GameObject;
var saucer : GameObject;
var player : GameObject;
var vCam : GameObject;
var vRef : GameObject;
var graph : GameObject;


function Start () {
	
}

function Update ()
{
	if(Input.GetKeyDown("e"))
	{
		if(insauc == true)
		{
			saucer.GetComponent(Saucer).enabled = false;
			playercam.GetComponent(SmoothFollow).enabled = false;
			
			player.transform.parent = null;
			player.transform.position = player.transform.position + new Vector3(-3.0, 3, 0.0);
			
			player.GetComponent(Rigidbody).isKinematic = false;
			playercam.GetComponent(MouseLook).enabled = true;
			player.GetComponent(CapsuleCollider).enabled = true;
			player.GetComponent(rigidwalker).enabled = true;
			playercam.transform.position = vCam.transform.position;
			playercam.transform.rotation = vCam.transform.rotation;
			player.transform.rotation.x = vRef.transform.rotation.x;
			player.transform.rotation.z = vRef.transform.rotation.z;
			
			insauc = false;
			saucer.GetComponent(AudioSource).mute = true;
			graph.animation.Play("sauceridle");
		}
	}
}

function OnHit()
{
	if(insauc == false)
	{
		player.GetComponent(rigidwalker).enabled = false;
		player.GetComponent(CapsuleCollider).enabled = false;
		playercam.GetComponent(MouseLook).enabled = false;
		player.GetComponent(Rigidbody).isKinematic = true;
		
		player.transform.parent = saucer.transform;
		player.transform.position = saucer.transform.position;
		player.transform.rotation = saucer.transform.rotation;
		
		saucer.GetComponent(Saucer).enabled = true;
		playercam.GetComponent(SmoothFollow).enabled = true;
		playercam.GetComponent(SmoothFollow).target = saucer.transform;
		
		saucer.GetComponent(AudioSource).mute = false;
		insauc = true;
		graph.animation.Play("saucerrotation");
	}
	
}