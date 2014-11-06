#pragma strict

function Start ()
{
	Die();
}

function Die () {
	yield WaitForSeconds(5);
	Destroy(gameObject);
}