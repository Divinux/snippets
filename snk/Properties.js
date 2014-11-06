//Handles all real estate properties and passes teh update call to each of them.

var aProps : GameObject[];
var vHomeless : GameObject;
var properties:Property[];


function fPropUpdate()
{
	for (var a in aProps)
	{
		a.GetComponent(Prop).vUpdate();
	}
}