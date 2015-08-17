var vDist : float = 200;
var vHitObj : Transform;

//raycast forward and send message to hit object
function Update ()
{
	if(Input.GetMouseButtonDown(0))
	{
		var hit : RaycastHit;
		if (Physics.Raycast (this.transform.position, this.transform.forward, hit, vDist))
		{
			print(hit.transform);
			Debug.DrawLine (this.transform.position, hit.point);
			vHitObj = hit.transform;
			vHitObj.SendMessage ("OnHit");
		}
	}
}