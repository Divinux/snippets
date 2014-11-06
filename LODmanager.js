#pragma strict
@AddComponentMenu("Scripts/Misc/LevelOfDetail")
@RequireComponent(MeshFilter)

enum LOD_LEVEL { LOD0, LOD1, LOD2 }

/*  Script to swap out meshes based on distance (LOD)
 *
 *  Original C# version by Rich Hudson 2009 - Kranky Boy Games
 *  Javascript conversion + optimizations by "Leepo" - M2H
 */
class LODmeshes extends  MonoBehaviour {
   
    public var lodMesh0 : Mesh;
    public var lodMesh1 : Mesh;
    public var lodMesh2 : Mesh;

    public var distanceLOD1 : float;
    public var distanceLOD2 : float;
   
    public var updateInterval : float = 1.0;
    private var currentLOD : LOD_LEVEL= LOD_LEVEL.LOD2;
	private var meshFilter : MeshFilter;
   	private var thisTransform : Transform;
   
    function Awake()
    {
    	meshFilter = GetComponent(MeshFilter);
      	thisTransform = transform;
      
      	//Distribute load by checkingLOD for every LOD script at a different time
      	var startIn : float = Random.Range(0.0, updateInterval);
      	InvokeRepeating("CheckLOD", startIn, updateInterval);
    }
   
    function CheckLOD()
    {
      var distanceFromObject : float = Vector3.Distance(thisTransform.position, Camera.main.transform.position);

      if (distanceFromObject < distanceLOD1 && currentLOD != LOD_LEVEL.LOD0)
      {
         currentLOD = LOD_LEVEL.LOD0;
         meshFilter.mesh = lodMesh0;
      }
      else if (distanceFromObject >= distanceLOD1 && distanceFromObject < distanceLOD2 && currentLOD != LOD_LEVEL.LOD1)
      {
         currentLOD = LOD_LEVEL.LOD1;
         meshFilter.mesh = lodMesh1;
      }
      else if (distanceFromObject >= distanceLOD2 && currentLOD != LOD_LEVEL.LOD2)
      {
         currentLOD = LOD_LEVEL.LOD2;
         meshFilter.mesh = lodMesh2;
      }
   }
   
} 