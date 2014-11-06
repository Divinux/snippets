var vDist : float = 200;
var vHitObj : Transform;

function Update ()
{
	if (gameObject.transform.root.CompareTag ("Player"))
	{
		if(Input.GetMouseButtonDown(0))
		{
			var hit : RaycastHit;
			if (Physics.Raycast (this.transform.position, this.transform.forward, hit, vDist))
			{
				print("pew");
				Debug.DrawLine (this.transform.position, hit.point);
				vHitObj = hit.transform;
				vHitObj.SendMessage ("OnHit");
			}
		}
	}
}