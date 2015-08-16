using UnityEngine;
using System.Collections;
using System.Collections.Generic;

//generates a terrain mesh from either heightmap or perlin noise(if no heightmap is present)
public class Meshgen : MonoBehaviour 
{
	//width, spacing of the mesh
	public int width = 10;
	public float spacing = 1f;
	//material for the mesh
	public Material material;
	//private components
	private MeshFilter terrainMesh = null;
	private MeshRenderer MeshRend = null;
	//heightmap texture sampling
	//texture needs read/write enabled
	//if no image is assigned, perlin noise is used
	public Texture2D Heightmap;
	//perlin sampling
	//seed for the height generation
	public float PerlinSeed = 1f;
	//scale for the perlin sampling
	public float PerlinScale = 1f;
	//scale for the detail perlin sampling
	public float PerlinScale2 = 1f;
	//height difference
	public float Amplitude = 1f;
	public float Amplitude2 = 0.1f;
	
	
	void Start() 
	{
		Mesh mesh = new Mesh();
		terrainMesh = gameObject.AddComponent<MeshFilter>();
		MeshRend = gameObject.AddComponent<MeshRenderer>();
		terrainMesh.mesh = mesh;
		
		if(material == null)
		{
			MeshRend.material = new Material(Shader.Find("Diffuse"));
		}
		else
		{
			MeshRend.material = material;
		}
		
		GenerateMesh();

	}
	
	float GetHeight(float x_coor, float z_coor)
	{
		float y_coor = 0f;
		if(Heightmap == null)
		{
			y_coor = Mathf.PerlinNoise(PerlinScale*x_coor+PerlinSeed+0.1f, PerlinScale*z_coor+PerlinSeed+0.1f);
			float y_coor2 = Mathf.PerlinNoise(PerlinScale2*x_coor+PerlinSeed+0.1f, PerlinScale2*z_coor+PerlinSeed+0.1f);
			y_coor += y_coor2 * Amplitude2;
		}
		else
		{
			int x = Mathf.FloorToInt(x_coor / width * Heightmap.width);
			int z = Mathf.FloorToInt(z_coor / width * Heightmap.height);
			y_coor = Heightmap.GetPixel(x,z).grayscale;
		}
		return y_coor*Amplitude;
	}
	
	void GenerateMesh ()
	{
		//lists for verts, tris, and uv map
		List<Vector3[]> verts = new List<Vector3[]>();
		List<int> tris = new List<int>();
		List<Vector2> uvs = new List<Vector2>();

		// Generate everything.
		for (int z = 0; z < width; z++)
		{
			verts.Add(new Vector3[width]);
			for (int x = 0; x < width; x++)
			{
				Vector3 current_point = new Vector3();
				current_point.x = (x * spacing);
				current_point.z = z * spacing;

				current_point.y = GetHeight(current_point.x, current_point.z);

				verts[z][x] = current_point;
				uvs.Add(new Vector2(x,z)); // TODO Add a variable to scale UVs.


				// Don't generate a triangle if it would be out of bounds.
				int current_x = x + (1);
				if (current_x-1 <= 0 || z <= 0 || current_x >= width)
				{
					continue;
				}
				// Generate the triangle north of you.
				tris.Add(x + z*width);
				tris.Add(current_x + (z-1)*width);
				tris.Add((current_x-1) + (z-1)*width);

				// Generate the triangle northwest of you.
				if (x-1 <= 0 || z <= 0)
				{
					continue;
				}
				tris.Add(x + z*width);
				tris.Add((current_x-1) + (z-1)*width);
				tris.Add((x-1) + z*width);
			}
		}

		

		// Unfold the 2d array of verticies into a 1d array.
		Vector3[] unfolded_verts = new Vector3[width*width];
		int i = 0;
		foreach (Vector3[] v in verts)
		{
			v.CopyTo(unfolded_verts, i * width);
			i++;
		}

		// Generate the mesh object.
		Mesh ret = new Mesh();
		ret.vertices = unfolded_verts;
		ret.triangles = tris.ToArray();
		ret.uv = uvs.ToArray();

		// Assign the mesh object and update it.
		ret.RecalculateBounds();
		ret.RecalculateNormals();
		ret.Optimize();
		terrainMesh.mesh = ret;

	}
}
