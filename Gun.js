var vInstPos : GameObject;
var vBullet : GameObject;
var vBulletInst : GameObject;
var vCam : Camera;
var vDir : Vector3;
var hHit : RaycastHit;
var vHitObj : Transform;

function Start ()
{
	vCam = transform.root.GetComponentInChildren(Camera);
	
}

function Update ()
{
	if(Input.GetMouseButtonDown(0) && transform.root.GetComponent(InventoryBySnake).isinoptions == -1)
	{
		Shoot();
		print("shot");
	}
}

function Shoot()
{
	vDir = vCam.transform.forward;
	
	vBulletInst = Instantiate(vBullet, vInstPos.transform.position, vInstPos.transform.rotation);
	vBulletInst.GetComponent(Projectile).vSpeed = transform.GetComponent(ItemStats).vSpeed;
	vBulletInst.GetComponent(Projectile).vPower = transform.GetComponent(ItemStats).vPower;
	
	if (Physics.Raycast(vCam.transform.position, vDir, hHit, 1000))
	{
		vHitObj = hHit.transform.root;
		vHitObj.SendMessage ("Damage", transform.root.GetComponentInChildren(ItemStats).vPower);
		print("Hit");
		Debug.DrawLine (vCam.transform.position, hHit.transform.position);
	}
	
	
	
	print("Pew pew");
}