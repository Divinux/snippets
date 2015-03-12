//originally written by http://www.youtube.com/user/mas5453
//part of tutorial, no license specified
//translated into Js and modified by Divinux
import System.Collections.Generic;


enum State {Idle, Walking};

var vTarget : GameObject;

var mSpeed : float;
var mSpeedMulti : float = 5.0;

var DebugMode : boolean;

var onNode : boolean = true;

var mTarget : Vector3 = new Vector3(0,0,0);

var currNode : Vector3;

var nodeIndex : int;

var path : List.<Vector3> = new List.<Vector3>();

var vSH : GameObject;
var vControl : NodeHandler;

var vState : State = State.Idle;



function Awake () 
{
	//find the node component. scripthandler needs to be assigned
	vControl = vSH.GetComponent(NodeHandler);
}

function Update () 
{
	switch(vState)
	{
		case vState.Idle:
		break;
		
		case vState.Walking:
		if (path != null)
		{
			if (onNode)
			{
				onNode = false;
				if (nodeIndex < path.Count)
				currNode = path[nodeIndex];
			} else
			fMoveToward();
		}
		break;
	}
}

//function to order character to move
function fMoveOrder(pos : GameObject)
{
	print("move order");
	mTarget = pos.transform.position;
	fSetTarget();
	fChangeState(State.Walking);
}

//actual move function
function fMoveToward()
{
	print("move toward");
	if (DebugMode)
	{
		for (var i=0; i<path.Count-1; ++i)
		{
			Debug.DrawLine(path[i], path[i+1], Color.white, 0.01f);
		}
	}
	
	var newPos : Vector3 = transform.position;

	var Xdistance : float = newPos.x - currNode.x;
	if (Xdistance < 0) Xdistance -= Xdistance*2;
	var Ydistance : float = newPos.z - currNode.z;
	if (Ydistance < 0) Ydistance -= Ydistance*2;
	
	if ((Xdistance < 0.5 && Ydistance < 0.5) && mTarget == currNode) //Reached target
	{
		fChangeState(vState.Idle);
	}
	else if (Xdistance < 0.5 && Ydistance < 0.5)
	{
		nodeIndex++;
		onNode = true;
	}
	/***Move toward waypoint***/

	transform.LookAt(new Vector3(currNode.x, transform.position.y, currNode.z));
	transform.rotation.x = 0;
	transform.rotation.z = 0;
	
	transform.Translate(Vector3.forward * mSpeedMulti * Time.deltaTime);
}

//calculates the path
function fSetTarget()
{
	print("set target");
	path = vControl.Path(transform.position, mTarget);
	nodeIndex = 0;
	onNode = true;
}

//changes states
function fChangeState(newState : State)
{
	print("change state");
	vState = newState;
}