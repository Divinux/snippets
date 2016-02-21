//set status to 1 to move to pos 2
//set status to 2 to move to 1
//speeds of rotation and translation
var vRotationspeed : float;
var vPositionSpeed : float;

//distance and angle stopping threshold
var vPosT : float;
var vRotT : float;

var vObject : Transform;
var vPos1 : Transform;
var vPos2 : Transform;

private var vAngle : float;
public var vStatus : int = 0;
function Update () 
{
	
	if(vStatus == 1)
	{
		fBack();
	}
	if(vStatus == 2)
	{
		fForth();
	}

}

function fBack()
{
	//move towards pos2
	vObject.localPosition = Vector3.Lerp(vObject.localPosition, vPos2.localPosition, vPositionSpeed * Time.deltaTime);
	vObject.localRotation = Quaternion.Slerp (vObject.localRotation, vPos2.localRotation, vRotationspeed * Time.deltaTime);

	//check if finished
	vAngle = Quaternion.Angle(vObject.localRotation, vPos2.localRotation);
	if(Vector3.Distance(vObject.localPosition, vPos2.localPosition) <= vPosT && vAngle <= vRotT)
	{
		vStatus = 0;
		vObject.localPosition = vPos2.localPosition;
		vObject.localEulerAngles = vPos2.localEulerAngles;
		
	}
}

function fForth()
{
	//move towards pos2
	vObject.localPosition = Vector3.Lerp(vObject.localPosition, vPos1.localPosition, vPositionSpeed * Time.deltaTime);

	vObject.localRotation = Quaternion.Slerp (vObject.localRotation, vPos1.localRotation, vRotationspeed * Time.deltaTime);
	
	//check if finished
	vAngle = Quaternion.Angle(vPos1.localRotation, vObject.localRotation);
	if(Vector3.Distance(vObject.localPosition, vPos1.localPosition) <= vPosT && vAngle <= vRotT)
	{
		vStatus = 0;
		vObject.localPosition = vPos1.localPosition;
		vObject.localEulerAngles = vPos1.localEulerAngles;
	}

}