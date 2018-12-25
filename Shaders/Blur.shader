Shader "TheFallenRealm/Fog/Blur"
{
    Properties
    {
		[HideInInspector]
		_MainTex("Main", 2D) = "white" {}
		[HideInInspector]
		_PastTexCount("", int) = 12 
		[HideInInspector]
		_PastTex0("Past 0", 2D) = "black" {}
		[HideInInspector]
		_PastTex1("Past 1", 2D) = "black" {}
		[HideInInspector]
		_PastTex2("Past 2", 2D) = "black" {}
		[HideInInspector]
		_PastTex3("Past 3", 2D) = "black" {}
		[HideInInspector]
		_PastTex4("Past 4", 2D) = "black" {}
		[HideInInspector]
		_PastTex5("Past 5", 2D) = "black" {}
		[HideInInspector]
		_PastTex6("Past 6", 2D) = "black" {}
		[HideInInspector]
		_PastTex7("Past 7", 2D) = "black" {}
		[HideInInspector]
		_PastTex8("Past 8", 2D) = "black" {}
		[HideInInspector]
		_PastTex9("Past 9", 2D) = "black" {}
		[HideInInspector]
		_PastTex10("Past 10", 2D) = "black" {}
		[HideInInspector]
		_PastTex11("Past 11", 2D) = "black" {}
		_BlurRadius("Blur Radius", float) = 5
		_BlurDistance("Blur Distance", float) = 0.007
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" }

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float _BlurRadius;
			float _BlurDistance;

			sampler2D _PastTex0, _PastTex1, _PastTex2, _PastTex3;
			sampler2D _PastTex4, _PastTex5, _PastTex6, _PastTex7;
			sampler2D _PastTex8, _PastTex9, _PastTex10, _PastTex11;
			int _PastTexCount;

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				float2 uv = (0, 0);
				float value = 0;
				int count = 0;
				for (int y = -_BlurRadius; y < _BlurRadius; y++)
				{
					uv[1] = i.uv[1] + (y * _BlurDistance);
					for (int x = -_BlurRadius; x < _BlurRadius; x++)
					{
						uv[0] = i.uv[0] + (x * _BlurDistance);
						value += tex2D(_MainTex, uv);
						count++;
					}
				}
				value /= count;
				
				if (_PastTexCount > 0) { value += tex2D(_PastTex0, i.uv); }
				if (_PastTexCount > 1) { value += tex2D(_PastTex1, i.uv); }
				if (_PastTexCount > 2) { value += tex2D(_PastTex2, i.uv); }
				if (_PastTexCount > 3) { value += tex2D(_PastTex3, i.uv); }
				if (_PastTexCount > 4) { value += tex2D(_PastTex4, i.uv); }
				if (_PastTexCount > 5) { value += tex2D(_PastTex5, i.uv); }
				if (_PastTexCount > 6) { value += tex2D(_PastTex6, i.uv); }
				if (_PastTexCount > 7) { value += tex2D(_PastTex7, i.uv); }
				if (_PastTexCount > 8) { value += tex2D(_PastTex8, i.uv); }
				if (_PastTexCount > 9) { value += tex2D(_PastTex9, i.uv); }
				if (_PastTexCount > 10) { value += tex2D(_PastTex10, i.uv); }
				if (_PastTexCount > 11) { value += tex2D(_PastTex11, i.uv); }

				value /= _PastTexCount + 1;

				return value;
			}
			ENDCG
		}
    }
}
