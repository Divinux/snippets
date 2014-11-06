var sperm : GameObject;
var pos : GameObject;


function OnHit()
{
	Instantiate(sperm, pos.transform.position, pos.transform.rotation);
	
}