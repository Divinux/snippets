var vHitObj : Transform;
var vDist : float = 2000;
var playercam : GameObject;
var hit: RaycastHit;
var weapon : GameObject;
var vBullet : GameObject;

function Update ()
{
	if(Input.GetMouseButtonDown(0))
	{
		Instantiate(vBullet, weapon.transform.position, weapon.transform.rotation);
		audio.Play();
		
		var ray : Ray = playercam.camera.ScreenPointToRay (Input.mousePosition);
		var hita : RaycastHit;
		if (Physics.Raycast (ray, hita))
		{
			// Create a particle if hit
			Debug.DrawRay (ray.origin, ray.direction * 10, Color.yellow);
		}
		vHitObj = hita.transform;
		vHitObj.SendMessage ("OnCarHit");
		
	}
	
	var rayc : Ray = playercam.camera.ScreenPointToRay (Input.mousePosition);
	if (Physics.Raycast (rayc, hit))
	{
		// Create a particle if hit
		//Debug.DrawRay (rayc.origin, rayc.direction * 10, Color.red);
		weapon.transform.LookAt(hit.point, Vector3.up);
	}
	
}