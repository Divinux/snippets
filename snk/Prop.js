//Handles the info about a singular real estate property. 

//Updates its value.
class Property{
  var name:String;
  var value:float;
  var isWorkplace:boolean=false;
   var propertyObject:GameObject;
}

//player object
var vPlayer : GameObject;
vPlayer = gameObject.FindWithTag("Player");

//ai nav points
var vEntry : GameObject;


var sName : String;
var sOwner : String;
var fValue : float;
var fMod : float;
var vIcon : Texture2D;

var vWorkplace : boolean;

function vUpdate()
{
	fValue = fValue * fMod;
	if(sOwner == "Player")
	{
		vPlayer.GetComponent(Spieler).vMoneyB += fValue/100;
	}
}

function fPropUpdate(){
  properties=new Property[aProps.length];
  for(var i:int;i<aProps.length;i++){
    var propc=aProps[i].GetComponent(Prop);
    propc.vUpdate();
    properties[i].name=propc.sName;
    properties[i].owner=propc.sOwner;
    properties[i].value=propc.fValue;
    properties[i].workplace=propc.vWorkplace; 
  } 
}
