using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Obstacles : MonoBehaviour
{

    public string loseText = "";
    public bool disable = false;

    void OnTriggerEnter(Collider other)
    {
        if (!disable && (other.name == "Drone" || other.tag == "Cargo"))
        {
            MainGame.gameOverScreen(loseText);
        }
    }

    private void OnCollisionEnter(Collision collision)
    {
        if (!disable && (collision.gameObject.name == "Drone" || collision.gameObject.tag == "Cargo"))
        {
            MainGame.gameOverScreen(loseText);
        }
    }
}
