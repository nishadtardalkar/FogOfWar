Shader "TheFallenRealm/Fog/Cookie"
{
    Properties
    {
		_RecurringCookie("RecurringCookie", 2D) = "black" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

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

			sampler2D _RecurringCookie;
			float _Data[259];
			int _Index;
			int _KeepUnfoged;

            v2f vert (appdata v)
            {
                v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
				float pi = 3.14159265;
				float resolution = _Data[0];
				float tani = (i.uv[1] - _Data[2]) / (i.uv[0] - _Data[1]);
				float angle = atan(abs(tani));
				if (i.uv[0] < _Data[1] && i.uv[1] > _Data[2])
				{
					angle = pi - angle;
				}
				else if (i.uv[0] < _Data[1] && i.uv[1] < _Data[2])
				{
					angle += pi;
				}
				else if (i.uv[0] > _Data[1] && i.uv[1] < _Data[2])
				{
					angle = 2 * pi - angle;
				}
				float index = angle / (2 * pi / resolution);

				float x, y;
				
				if ((int)index + 1 >= resolution)
				{
					x = _Data[3 + ((int)index * 2)] + (_Data[3] - _Data[3 + ((int)index * 2)]) * (index - (int)index);
					y = _Data[4 + ((int)index * 2)] + (_Data[4] - _Data[4 + ((int)index * 2)]) * (index - (int)index);
				}
				else
				{
					x = _Data[3 + ((int)index * 2)] + (_Data[3 + (((int)index + 1) * 2)] - _Data[3 + ((int)index * 2)]) * (index - (int)index);
					y = _Data[4 + ((int)index * 2)] + (_Data[4 + (((int)index + 1) * 2)] - _Data[4 + ((int)index * 2)]) * (index - (int)index);
				}
				float value = pow(pow(x - _Data[1], 2) + pow(y - _Data[2], 2), 0.5);

				float dist = (pow(pow(i.uv[0] - _Data[1], 2) + pow(i.uv[1] - _Data[2], 2), 0.5));
				if (dist > value)
				{
					if (_KeepUnfoged == 0)
					{
						if (_Index > 0)
						{
							return tex2D(_RecurringCookie, i.uv);
						}
						return float4(0.05, 0.05, 0.05, 1);
					}
					else 
					{
						return tex2D(_RecurringCookie, i.uv);
					}
				}
				return 1;
            }
            ENDCG
        }

    }
}
