Shader "Custom/WrappedLamb" 
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
		#pragma surface surf WrapLambert
		sampler2D _MainTex;
		sampler2D _RampTex;
		inline half4 LightingWrapLambert (SurfaceOutput s, half3 lightDir, half atten) 
		{
        half NdotL = dot (s.Normal, lightDir);
        half diff = NdotL * 0.5 + 0.5;
        half4 c;
        c.rgb = s.Albedo * _LightColor0.rgb * (diff * atten * 2);
        c.a = s.Alpha;
        return c;
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