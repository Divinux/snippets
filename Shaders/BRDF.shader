Shader "Custom/BRDF" 
{
	Properties 
	{
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_RampTex ("ramp (RGB)", 2D) = "white" {}
	}
	SubShader 
	{
		Tags { "RenderType"="Opaque" }
		LOD 200
		CGPROGRAM
		#pragma surface surf BasicDiffuse
		sampler2D _MainTex;
		sampler2D _RampTex;
		inline float4 LightingBasicDiffuse (SurfaceOutput s, fixed3 lightDir, half3 viewDir, fixed atten)
		{
			float difLight = max(0, dot (s.Normal, lightDir));
			float rimLight = dot(s.Normal, viewDir);
			float hLambert = difLight * 0.5 + 0.5;
			float3 ramp = tex2D(_RampTex, float2(hLambert, rimLight)).rgb;
			
			float4 col;
			col.rgb = s.Albedo * _LightColor0.rgb * (ramp);
			col.a = s.Alpha;
			return col;
		}
		struct Input 
		{
			float2 uv_MainTex;
		};
		void surf (Input IN, inout SurfaceOutput o) 
		{
			half4 c = tex2D (_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}