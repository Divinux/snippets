//explodes an object by replacing it with a destroyed model and flinging it apart
var explosion : GameObject;
var nextpref : GameObject;
var colliders : Collider[];
var expSprite : GameObject;

var radius = 1.0;
var power = 10.0;

function Awake()
{
	
	colliders= Physics.OverlapSphere (transform.position, radius);
}

function OnCarHit()
{
	Instantiate(explosion, transform.position, transform.rotation);
	Instantiate(nextpref, transform.position, transform.rotation);
	Instantiate(expSprite, transform.position, transform.rotation);
	Explode();
	Destroy (gameObject);
}




function Explode ()
{
	// Applies an explosion force to all nearby rigidbodies
	var explosionPos : Vector3 = transform.position;
	var colliders : Collider[] = Physics.OverlapSphere (explosionPos, radius);
	
	for (var hit : Collider in colliders) {
		if (!hit)
		continue;
		
		if (hit.rigidbody)
		hit.rigidbody.AddExplosionForce(power, explosionPos, radius, 1.0, ForceMode.Impulse);
	}
}