//UNITY_SHADER_NO_UPGRADE

Shader "Unlit/TextureShader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			uniform sampler2D _MainTex;	

			struct vertIn
			{
				float4 vertex : POSITION;
				float4 vertexColor : COLOR;
				float2 uv : TEXCOORD0;
			};

			struct vertOut
			{
				float4 vertex : SV_POSITION;
				float4 vertexColor : COLOR;
				float2 uv : TEXCOORD0;
			};

			// Implementation of the vertex shader
			vertOut vert(vertIn v)
			{
				vertOut o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.vertexColor = v.vertexColor;
				o.uv = v.uv;
				return o;
			}
			
			// Implementation of the fragment (pixel) shader
			fixed4 frag(vertOut v) : SV_Target
			{
				fixed4 texColor = tex2D(_MainTex, v.uv);
				float f = sin(_Time * 5) * 0.5 + 0.5;
				float4 color = f * texColor + (1.0 - f) * v.vertexColor;
				return color;
			}
			ENDCG
		}
	}
}
