var incar : boolean = false;
var carcam : GameObject;
var playercam : GameObject;
var car : GameObject;
var player : GameObject;
var vCam : GameObject;
var vRef : GameObject;
var playergraphics : GameObject;
var weapon : GameObject;
var pivot : GameObject;



function Update ()
{
	if(Input.GetKeyDown("e"))
	{
		if(incar == true){
			car.GetComponent(CarController).enabled = false;
			playercam.GetComponent(SmoothFollow).enabled = false;
			playergraphics.GetComponent(MeshRenderer).enabled = true;
			
			player.transform.parent = null;
			player.transform.position = player.transform.position + new Vector3(-3.0, 2, 0.0);
			
			player.GetComponent(Rigidbody).isKinematic = false;
			playercam.GetComponent(MouseLook).enabled = true;
			player.GetComponent(CapsuleCollider).enabled = true;
			player.GetComponent(rigidwalker).enabled = true;
			playercam.transform.position = vCam.transform.position;
			playercam.transform.rotation = vCam.transform.rotation;
			player.transform.rotation.x = vRef.transform.rotation.x;
			player.transform.rotation.z = vRef.transform.rotation.z;
			
			incar = false;
			weapon.GetComponent(RaycasterCar).enabled = false;
			car.GetComponent(Rigidbody).drag = 10;
			Spasmfix();
			
			
			Screen.showCursor=false;
			Screen.lockCursor=true;
		}
	}
}

function Spasmfix()
{
	yield WaitForSeconds (1);
	car.GetComponent(CarController).enabled = true;
	car.GetComponent(CarController).enabled = false;
}

function OnHit()
{
	if(incar == false)
	{
		player.GetComponent(rigidwalker).enabled = false;
		player.GetComponent(CapsuleCollider).enabled = false;
		playercam.GetComponent(MouseLook).enabled = false;
		player.GetComponent(Rigidbody).isKinematic = true;
		playergraphics.GetComponent(MeshRenderer).enabled = false;
		
		player.transform.parent = car.transform;
		player.transform.position = car.transform.position;
		player.transform.rotation = car.transform.rotation;
		
		pivot = car.FindGameObjectsWithTag("Pivot")[0];
		
		car.GetComponent(CarController).enabled = true;
		playercam.GetComponent(SmoothFollow).enabled = true;
		playercam.GetComponent(SmoothFollow).target = pivot.transform;
		incar = true;
		weapon.GetComponent(RaycasterCar).enabled = true;
		
		car.GetComponent(Rigidbody).drag = 0;
		
		Screen.showCursor=true;
		Screen.lockCursor=false;
	}
	
}