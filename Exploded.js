var radius = 1.0;
var power = 10.0;

//adds an explosionforce to all objects nearby
function Start ()
{
	var explosionPos : Vector3 = transform.position;
	var colliders : Collider[] = Physics.OverlapSphere (explosionPos, radius);
	
	for (var hit : Collider in colliders) {
		if (!hit)
		continue;
		
		if (hit.rigidbody)
		hit.rigidbody.AddExplosionForce(power, explosionPos, radius, 0.1, ForceMode.Impulse);
		
	}
	audio.Play();
}

function Update ()
{
	
}