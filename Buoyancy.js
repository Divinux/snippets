//*

	// Buoyancy.cs
	// by Alex Zhdankin
	// Version 2.1
	//
	// http://forum.unity3d.com/threads/72974-Buoyancy-script
	//
	// Terms of use: do whatever you like


	// Buoyancy.js
	// resconstructed for multi colliders dependent from rigidbody
	// by Marvin Papin
	// Version 1.0
	//
	// http://forum.unity3d.com/threads/72974-Buoyancy-script
	//
	// Terms of use: do whatever you like


	// Effects : Find each colliders attached to rigidbody and get points according to the dimension of the rigidbody
	//	slices : each colliders according to bounds, calculate slices for each axis according to local bounds (ex on X : size rigidB = 10, collider analysed = 2, number of slice on X = 20, calculated slice for that object === 20/(10/2) = 5)
	//	    |-> allow found points to "fall" better into objects for thin walls rigidBody by example.


	// IMPORTANT : avoid to much important slices, maybe i did wrong but that could be unrealistic or event make unity bug (50x50x50 points in = bug)
	// Do not work with concave colliders (is this really usefull ?) because they are hollow.
	// Use any other colliders MeshCollider(Covex), BoxCollider, SphereCollider...


	var waterLevel : float = -4.33f;
	var density : float = 500.0f;
	var slicesX : int = 5.0; // transformed according to dimension ratio with whole rigidbody bounds
	var slicesY : int = 5.0;
	var slicesZ : int = 5.0;
	var voxelsLimit : int = 16;
	
	private var layerEmpty : int = 7; // a layer where the object will be placed to cast rays at pos0, the last built-in array is probably the less used

	private var WATER_DENSITY : float = 1000.0f;
	private var DAMPFER : float = 0.03f; // resistance to movement / visquosity

	private var voxelHalfHeight : float;
	private var localArchimedesForce : Vector3;
	private var voxels : Vector3[];
	private var forces = new Array(); // For drawing force gizmos
	
	private var combinedBounds : Bounds;
	private var boundsList : Bounds[];


	function Awake()
	{

	// Store original rotation and position
		var originalParent : Transform = transform.parent; //keep order
		transform.parent = null;
		var originalRotation : Quaternion = transform.rotation;
		var originalPosition : Vector3 = transform.position;
		var originalScale : Vector3 = transform.localScale;
		transform.rotation = Quaternion.identity;
		transform.position = Vector3.zero;
		transform.localScale = Vector3.one;
		
	// Get whole rigidbody bounds
		var collidersArray : Array = new Array(0);
		var colliders : Collider[];
		collidersArray = GetCollidersRecursively(gameObject);
		colliders = collidersArray.ToBuiltin(Collider);
	    var nbColliders : int = colliders.length;
	    if (nbColliders == 0) // The object must have a collider
	    {
			gameObject.AddComponent(MeshCollider);
			colliders = new Collider[1];
			boundsList = new Bounds[1];
			colliders[0] = collider;
			boundsList[0] = collider.bounds;
			Debug.LogWarning("You are trying to calculate buoyancy on -" + transform.name + "- which has no collider even in children");
	    }
	    else // boundList
	    {
		    boundsList = new Bounds[nbColliders];
			for (var c1 = 0; c1 < nbColliders; c1++) boundsList[c1] = colliders[c1].bounds;
		}
		// combined Bounds
		for (var b1 = 0; b1 < nbColliders; b1++) combinedBounds.Encapsulate(boundsList[b1]);
		
	// Get a reference height
		var bounds : Bounds = combinedBounds;
		voxelHalfHeight = Mathf.Min(bounds.size.x, bounds.size.y, bounds.size.z);
		voxelHalfHeight /= 2 * (slicesX + slicesY + slicesZ)*1.0f/3;
		
	// The object must have a RidigBody
		if (rigidbody == null)
		{
			gameObject.AddComponent(Rigidbody);
			Debug.LogWarning("You are trying to calculate buoyancy on -" + transform.name + "- which has no Rigidbody attached");
		}
		//rigidbody.centerOfMass = Vector3(0, -bounds.extents.y * 0f, 0) + transform.InverseTransformPoint(bounds.center);

		voxels = SliceIntoVoxels(boundsList, colliders);

	// Restore original rotation and position
		transform.rotation = originalRotation;
		transform.position = originalPosition;
		transform.localScale = originalScale;
		transform.parent = originalParent;

		var volume : float = rigidbody.mass / density;

		WeldPoints(voxels, voxelsLimit);

		var archimedesForceMagnitude : float = WATER_DENSITY * Mathf.Abs(Physics.gravity.y) * volume;
		localArchimedesForce = Vector3(0, archimedesForceMagnitude, 0) / voxels.length;
		
		//Debug.Log(string.Format("[Buoyancy.cs] Name=\"{0}\" volume={1:0.0}, mass={2:0.0}, density={3:0.0}", name, volume, rigidbody.mass, density));
	}
	
		    function GetCollidersRecursively (obj : GameObject) : Array // limited to Rigidbody area
	        {
	        	var listColliders : Array = new Array(0);
	            if (!obj) return;
	            var col : Collider = obj.GetComponent(Collider);
	            if (col)
	            {
	            	if (!col.isTrigger) listColliders.Push(col);
	            }
	            
	            for (var child : Transform in obj.transform)
	            {
	                if (!child) continue;
	                if (child.GetComponent(Rigidbody)) continue; // get rid of children physically independent
	                var tempArray : Array = new Array(0);
	                tempArray = GetCollidersRecursively(child.gameObject);
	                listColliders = listColliders.Concat(tempArray);
	            }
	            return listColliders;
	        }
	
			function SliceIntoVoxels(bounds : Bounds[], colliders : Collider[])
			{
				var points : Array = new Array(0);
				var nbColliders : int = colliders.length;
				var layer : int[] = new int[nbColliders];
				for (var c1 = 0; c1 < nbColliders; c1++)
				{
					layer[c1] = colliders[c1].gameObject.layer;				// Place rigidbody into an empty layer to cast points
					colliders[c1].gameObject.layer = layerEmpty;			// store original layers
					points = points.Concat(SlicePerCollider(bounds[c1], layerEmpty));	// Get points in the colliders for each bounds of them
				}
				
				if (points.length == 0) points.Add(transform.position);
				
				for (var c3 = 0; c3 < nbColliders; c3++) colliders[c3].gameObject.layer = layer[c3]; // Replace rigidbody members into right layer
				
				return points.ToBuiltin(Vector3);
			}
			
				    function SlicePerCollider(bounds : Bounds, layerEmpty : int)
			        {
			        	var slicesLocalX : float = Mathf.CeilToInt(slicesX * bounds.size.x / combinedBounds.size.x);
			        	var slicesLocalY : float = Mathf.CeilToInt(slicesY * bounds.size.y / combinedBounds.size.y);
			        	var slicesLocalZ : float = Mathf.CeilToInt(slicesZ * bounds.size.z / combinedBounds.size.z);
			        	//slicesLocalX = Mathf.Max(slicesLocalX, 2.0);
			        	//slicesLocalY = Mathf.Max(slicesLocalY, 2.0);
			        	//slicesLocalZ = Mathf.Max(slicesLocalZ, 2.0);
						// Whole GO slicing
						var points : Array = new Array(0);
						var p : Vector3;
						var wp : Vector3;
						var x : float;
						var y : float;
						var z : float;
						for (var ix : int = 0; ix < slicesLocalX; ix++)
						{
							for (var iy : int = 0; iy < slicesLocalY; iy++)
							{
								for (var iz : int = 0; iz < slicesLocalZ; iz++)
								{
									x = bounds.min.x + bounds.size.x / slicesLocalX * (0.5f + ix);
									y = bounds.min.y + bounds.size.y / slicesLocalY * (0.5f + iy);
									z = bounds.min.z + bounds.size.z / slicesLocalZ * (0.5f + iz);
				
									wp = Vector3(x, y, z);
									
									var l : float = 0.1;//rayLength
									var hit : RaycastHit;
									if (Physics.CheckSphere(wp, l, 1 << layerEmpty))
									{
										p = transform.InverseTransformPoint(wp);
										points.Add(p);
										Debug.DrawLine(wp, wp+Vector3.one*l, Color.yellow, 20.0, false);
									}
									else Debug.DrawLine(wp, wp+Vector3.one*l/10, Color.black, 20.0, true);
								}
							}
						}
						return points;
			        }
			        
			private var firstIndex : int;
			private var secondIndex : int;
			
			function WeldPoints(listBuiltin : Vector3[], targetCount : int)
			{
				var list = new Array();
				for (var i : int = 0; i < listBuiltin.length; i++) list.Push(listBuiltin[i]);
				if (list.length <= 2 || targetCount < 2)
				{
					return;
				}
				
				var mixed : Vector3;
				while (list.length > targetCount)
				{
					FindClosestPoints(list); // pass by private var : firstIndex, secondIndex
		
					mixed = (list[firstIndex] + list[secondIndex]) * 0.5f;
					list.RemoveAt(secondIndex); // the second index is always greater that the first => removing the second item first
					list.RemoveAt(firstIndex);
					list.Add(mixed);
				}
				return list.ToBuiltin(Vector3);
			}
			
					function FindClosestPoints(list : Array)
					{
						var minDistance : float = float.MaxValue;
						var maxDistance : float = float.MinValue;
						firstIndex = 0;
						secondIndex = 1;
						
						var distance : float;
						for (var i : int = 0; i < list.length - 1; i++)
						{
							for (var j : int = i + 1; j < list.length; j++)
							{
								distance = Vector3.Distance(list[i], list[j]);
								if (distance < minDistance)
								{
									minDistance = distance;
									firstIndex = i;
									secondIndex = j;
								}
								if (distance > maxDistance)
								{
									maxDistance = distance;
								}
							}
						}
					}




	function FixedUpdate()
	{
		forces = new Array(); // For drawing force gizmos

		for (var point in voxels)
		{
			var wp : Vector3 = transform.TransformPoint(point);
			var waterLevel : float = GetWaterLevel();

			if (wp.y - voxelHalfHeight < waterLevel)
			{
				var k : float = (waterLevel - wp.y) / (2 * voxelHalfHeight) + 0.5f;
				if (k > 1)
				{
					k = 1f;
				}
				else if (k < 0)
				{
					k = 0f;
				}

				var velocity : Vector3 = transform.rigidbody.GetPointVelocity(wp);
				var localDampingForce : Vector3 = -velocity * DAMPFER * rigidbody.mass;
				var force : Vector3 = localDampingForce + Mathf.Sqrt(k) * localArchimedesForce;
				rigidbody.AddForceAtPosition(force, wp);
				
				var adding : Vector3[] = new Vector3[2];
				adding[0] = wp;
				adding[1] = force;
				forces.Push(adding); // For drawing force gizmos
			}
		}
	}
	
			function GetWaterLevel()
			{
		//		return ocean == null ? 0.0f : ocean.GetWaterHeightAtLocation(x, z);
				return waterLevel;
			}
	
	function OnDrawGizmos()
	{
		var gizmoSize : float = 0.0005f * rigidbody.mass;
		
		// draw forces and application points
		if (voxels && forces)
		{
			Gizmos.color = Color.yellow;
	
			for (var p in voxels)
			{
				Gizmos.DrawCube(transform.TransformPoint(p), Vector3(gizmoSize, gizmoSize, gizmoSize));
			}
	
			Gizmos.color = Color.cyan;
	
			for (var force : Vector3[] in forces)
			{
				Gizmos.DrawCube(force[0], Vector3(gizmoSize, gizmoSize, gizmoSize));
				Gizmos.DrawLine(force[0], force[0] + force[1] / rigidbody.mass);
			}
		}
	}







			
				    /*function SetLayerRecursively(obj : GameObject, newLayer : int) // limited to Rigidbody area
			        {
			            if (!obj) return;
			            obj.layer = newLayer;
			           
			            for (var child : Transform in obj.transform)
			            {
			                if (!child) continue;
			                if (child.GetComponent(Rigidbody)) continue; // get rid of children physically independent
			                SetLayerRecursively(child.gameObject, newLayer);
			            }
			        }//*/
			        
			        
			        
			        
			        