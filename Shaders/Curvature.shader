Shader "Custom/CurvedWorld" {
	Properties {
		// Diffuse texture
		_MainTex ("Base (RGB)", 2D) = "white" {}
		//second texture
		_Texture2 ("Base2 (RGB)", 2D) = "white" {}
		//blending slider
		_Blend ("Blend", Range (0, 1) ) = 0.0
		// Degree of curvature
		_Curvature ("Curvature", Float) = 0.001
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Surface shader function is called surf, and vertex preprocessor function is called vert
		// addshadow used to add shadow collector and caster passes following vertex modification
		#pragma surface surf Lambert vertex:vert addshadow

		// Access the shaderlab properties
		uniform sampler2D _MainTex;
		uniform sampler2D _Texture2;
		float _Blend;
		uniform float _Curvature;

		// Basic input structure to the shader function
		// requires only a single set of UV texture mapping coordinates
		struct Input {
			float2 uv_MainTex;
		};

		// This is where the curvature is applied
		void vert( inout appdata_full v)
		{
			// Transform the vertex coordinates from model space into world space
			float4 vv = mul( _Object2World, v.vertex );

			// Now adjust the coordinates to be relative to the camera position
			vv.xyz -= _WorldSpaceCameraPos.xyz;

			// Reduce the y coordinate (i.e. lower the "height") of each vertex based
			// on the square of the distance from the camera in the z axis, multiplied
			// by the chosen curvature factor
			vv = float4( 0.0f, ((vv.z * vv.z) + (vv.x * vv.x)) * - _Curvature, 0.0f, 0.0f );

			// Now apply the offset back to the vertices in model space
			v.vertex += mul(_World2Object, vv);
		}

		// This is just a default surface shader
		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			fixed4 d = tex2D(_Texture2, IN.uv_MainTex);
			o.Emission = lerp(c, d, _Blend);
			o.Albedo = (0, 0, 0); //c.rgb;
			o.Alpha = 1;//c.a;
		}
		ENDCG
	}
	// FallBack "Diffuse"
}