//originally written by http://www.youtube.com/user/mas5453
//part of tutorial, no license specified
//translated into Js and modified by Divinux

import System.Collections.Generic;

var  nodeTag : String;
var  vDistance : float;
var lowestScore : float = 0;

//class for single node point
class Point
{
	var m_pos : Vector3;
	var  m_state:String = "u";
	var  m_score:float = 0;
	var m_prevPoint : Point;
	
	var m_connectedPoints : List.<Point> = new List.<Point>();
	var m_potentialPrevPoints : List.<Point> = new List.<Point>();
	
	function Point( pos : Vector3,  state : String)
	{
		m_pos = pos;
		m_state = state;
	}
	function GetState()
	{
		return m_state;
	}
	
	function GetPos()
	{
		return m_pos;
	}
	
	function GetConnectedPoints()
	{
		return m_connectedPoints;
	}
	
	function GetPrevPoint()
	{
		return m_prevPoint;
	}
	
	function GetScore()
	{
		return m_score;
	}
	
	function GetPotentialPrevPoints()
	{
		return m_potentialPrevPoints;
	}
	
	function AddConnectedPoint(point : Point)
	{
		m_connectedPoints.Add(point);
	}
	
	function AddPotentialPrevPoint(point : Point)
	{
		m_potentialPrevPoints.Add(point);
	}
	
	function SetPrevPoint(point : Point)
	{
		m_prevPoint = point;
	}
	
	function SetState(newState : String)
	{
		m_state = newState;
	}
	
	function SetScore( newScore : float)
	{
		m_score = newScore;
	}
}

function Path(startPos : Vector3, targetPos : Vector3)
{
	var path : List.<Vector3> = new List.<Vector3>();
	//find distance to target
	var exitDistance :float = Vector3.Distance(startPos, targetPos);
	//if it's bigger than stopping distance, decrease by stopping distance
	if (exitDistance > .7f)
	{
		exitDistance -= .7f;
	}
	//is the exit closeby
	if(exitDistance < vDistance)
	{
		//Can I see the exit
		if (!Physics.Raycast(startPos, targetPos - startPos, exitDistance))
		{
			
			path.Add(startPos);
			path.Add(targetPos);
			return path;
		}
	}
	var nodes : GameObject[];
	nodes = GameObject.FindGameObjectsWithTag(nodeTag);
	var points : List.<Point> = new List.<Point>();

	for (var node in nodes)
	{
		var currNode : Point = new Point(node.transform.position, "u");
		points.Add(currNode);
	}
	//create finish point
	var endPoint : Point = new Point(targetPos, "e");

	for(var point in points) //Could be optimized to not go through each connection twice
	{
		for (var point2 in points)
		{
			var distance : float = Vector3.Distance(point.GetPos(), point2.GetPos());
			if(distance < vDistance){
				if (!Physics.Raycast(point.GetPos(), point2.GetPos() - point.GetPos(), distance))
				{
					//Debug.DrawRay(point.GetPos(), point2.GetPos() - point.GetPos(), Color.white, 1);
					point.AddConnectedPoint(point2);
				}}
		}
		var distance2 : float = Vector3.Distance(targetPos, point.GetPos());
		if(distance2 < vDistance){
			if (!Physics.Raycast(targetPos, point.GetPos() - targetPos, distance2))
			{
				//Debug.DrawRay(targetPos, point.GetPos() - targetPos, Color.white, 1);
				point.AddConnectedPoint(endPoint);
			}}
	}

	//points startPos can see
	for (var point in points)
	{
		var distance3 : float = Vector3.Distance(startPos, point.GetPos());
		if(distance3 < vDistance){

			if (!Physics.Raycast(startPos, point.GetPos() - startPos, distance3))
			{
				//Debug.DrawRay(startPos, point.GetPos() - startPos, Color.white, 1);
				var startPoint : Point = new Point(startPos, "s");
				point.SetPrevPoint(startPoint);
				point.SetState("o");
				point.SetScore(distance3 + Vector3.Distance(targetPos, point.GetPos()));
			}}
	}

	//Go through until we find the exit or run out of connections
	var searchedAll : boolean = false;
	var foundEnd : boolean = false;
	
	while(!searchedAll)
	{
		searchedAll = true;
		var foundConnections : List.<Point> = new List.<Point>();
		for (var point in points)
		{
			if (point.GetState() == "o")
			{
				searchedAll = false;
				var potentials : List.<Point> = new List.<Point>();
				potentials = point.GetConnectedPoints();
				
				for (var potentialPoint in potentials)
				{
					if (potentialPoint.GetState() == "u")
					{
						potentialPoint.AddPotentialPrevPoint(point);
						foundConnections.Add(potentialPoint);
						potentialPoint.SetScore(Vector3.Distance(startPos, potentialPoint.GetPos()) + Vector3.Distance(targetPos, potentialPoint.GetPos()));
					} else if (potentialPoint.GetState() == "e")
					{
						//Found the exit
						foundEnd = true;
						endPoint.AddConnectedPoint(point);
					}
				}
				point.SetState("c");
			}
		}
		for (var connection in foundConnections)
		{
			connection.SetState("o");
			//Find lowest scoring prev point
			lowestScore = 0;
			var bestPrevPoint : Point = null;
			var first : boolean = true;
			for (var prevPoints in connection.GetPotentialPrevPoints())
			{
				if (first)
				{
					lowestScore = prevPoints.GetScore();
					bestPrevPoint = prevPoints;
					first = false;
				} else
				{
					if (lowestScore > prevPoints.GetScore())
					{
						lowestScore = prevPoints.GetScore();
						bestPrevPoint = prevPoints;
					}
				}
			}
			connection.SetPrevPoint(bestPrevPoint);
		}
	}


	if (foundEnd)
	{
		//trace back finding shortest route (lowest score)
		var shortestRoute : List.<Point> = null;
		lowestScore = 0;
		var firstRoute : boolean = true;
		
		for (var point in endPoint.GetConnectedPoints())
		{
			var score : float = 0;
			var tracing : boolean = true;
			var currPoint : Point = point;
			var route : List.<Point> = new List.<Point>();
			route.Add(endPoint);
			while(tracing)
			{
				route.Add(currPoint);
				if (currPoint.GetState() == "s")
				{
					if (firstRoute)
					{
						shortestRoute = route;
						lowestScore = score;
						firstRoute = false;
					} else
					{
						if (lowestScore > score)
						{
							shortestRoute = route;
							lowestScore = score;
						}
					}
					tracing = false;
					break;
				}
				score += currPoint.GetScore();
				currPoint = currPoint.GetPrevPoint();
			}
		}
		
		shortestRoute.Reverse();
		path = new List.<Vector3>();
		for (var point in shortestRoute)
		{
			path.Add(point.GetPos());
		}
		return path;
	} else
	{
		return null;
	}
}