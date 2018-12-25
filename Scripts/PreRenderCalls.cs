using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PreRenderCalls : MonoBehaviour
{
    public Fog _Fog;

    void OnPreRender()
    {
        // FOG CALL
        _Fog.SetCookie();
    }
}
