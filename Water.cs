using UnityEngine;
 using System.Collections;
 
 public class Water : MonoBehaviour
 {
    public float scale = 0.1f;
    public float speed = 1.0f;
    public float noiseStrength = 1f;
    public float noiseWalk = 1f;
 
    private Vector3[] baseHeight;
	Vector3 vertex;
     void Update () 
	 {
         Mesh mesh = GetComponent<MeshFilter>().mesh;
   
         if (baseHeight == null)
             baseHeight = mesh.vertices;
   
         Vector3[] vertices = new Vector3[baseHeight.Length];
         for (int i=0;i<vertices.Length;i++)
         {
             vertex = baseHeight[i];
             vertex.y += Mathf.Sin(Time.time * speed+ baseHeight[i].x + baseHeight[i].y + baseHeight[i].z) * scale;
             vertex.y += Mathf.PerlinNoise(baseHeight[i].x + noiseWalk, baseHeight[i].y + Mathf.Sin(Time.time * 0.1f)) * noiseStrength;
             vertices[i] = vertex;
         }
         mesh.vertices = vertices;
         mesh.RecalculateNormals();
     }
 }