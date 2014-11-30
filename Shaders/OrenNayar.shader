 Shader "Custom/Oren-NayarTest2" {
     Properties {
         _MainTex ("Base (RGB)", 2D) = "white" {}
         _BumpTex("Bump",2D)="bump"{}
         _NormalIntensity("Intensity",Range(0,2))=1
         _Roughness("Roughness",float)=0.0
     }
     SubShader {
         Tags { "RenderType"="Opaque" }
         LOD 200
         
         CGPROGRAM
         #pragma surface surf Oren_Nayar
         #pragma target 3.0
         float _Roughness;
         inline float4 LightingOren_Nayar(SurfaceOutput s,half3 lightDir,half3 viewDir,half atten){
         //roughness A and B
         float roughness = _Roughness;
         float roughness2=roughness*roughness;
         float2 oren_nayar_fraction = roughness2/(roughness2 + float2(0.33,0.09));
         float2 oren_nayar = float2(1, 0) + float2(-0.5, 0.45) * oren_nayar_fraction;
         
         //Theta and phi
         float2 cos_theta = saturate(float2(dot(s.Normal,lightDir),dot(s.Normal,viewDir)));
         float2 cos_theta2 = cos_theta * cos_theta;
         float sin_theta = sqrt((1-cos_theta2.x)*(1-cos_theta2.y));
         float3 light_plane = normalize(lightDir - cos_theta.x*s.Normal);
         float3 view_plane = normalize(viewDir - cos_theta.y*s.Normal);
         float cos_phi = saturate(dot(light_plane, view_plane));
         
         //composition
         
         float diffuse_oren_nayar = cos_phi * sin_theta / max(cos_theta.x, cos_theta.y);
         
         float diffuse = cos_theta.x * (oren_nayar.x + oren_nayar.y * diffuse_oren_nayar);
         float4 col;
         col.rgb =s.Albedo * _LightColor0.rgb*(diffuse*atten);
         col.a = s.Alpha;
         return col;
         
         }
 
         sampler2D _MainTex;
         sampler2D _BumpTex;
         float _NormalIntensity;
         
 
         struct Input {
             float2 uv_MainTex;
             float2 uv_BumpTex;
         };
 
         void surf (Input IN, inout SurfaceOutput o) {
             half4 c = tex2D (_MainTex, IN.uv_MainTex);
             half3 normalMap= UnpackNormal(tex2D(_BumpTex,IN.uv_BumpTex));
             normalMap = float3(normalMap.x * _NormalIntensity,normalMap.y * _NormalIntensity,normalMap.z);
             o.Albedo = c.rgb;
             o.Normal = normalMap.rgb;
             o.Alpha = c.a;
         }
         ENDCG
     } 
     FallBack "Diffuse"
 }