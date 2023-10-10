using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Sign : MonoBehaviour
{
    [SerializeField] string signText;
    private HUD hudScript;
    
    void Start()
    {
        GameObject hud = GameObject.Find("HUD");
        hudScript = hud.GetComponent<HUD>();
    }

    private void OnTriggerEnter2D(Collider2D c)
    {
        hudScript.writeToPlayer(signText);
    }


    private void OnTriggerExit2D(Collider2D other)
    {
        hudScript.writeToPlayer("");
    }

}

