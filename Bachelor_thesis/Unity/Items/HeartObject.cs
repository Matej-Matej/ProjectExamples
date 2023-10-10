using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HeartObject : MonoBehaviour
{

    private void OnTriggerEnter2D(Collider2D c)
    {
        if (FindObjectsOfType<GameState>()[0].gainLife())
        {
            Destroy(gameObject);
        }
        
    }



}
