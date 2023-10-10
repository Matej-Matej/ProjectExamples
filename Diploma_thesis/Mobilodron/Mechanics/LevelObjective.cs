using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class LevelObjective : MonoBehaviour
{
    public string winningText = "";

    private bool isDroneInside = false;

    // Update is called once per frame
    void Update()
    {
        if (isDroneInside)
        {
            if (!MainGame.getPerformingCommands())
            {
                MainGame.openWinScreen(winningText);
            }
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Drone") {
            isDroneInside = true;
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.tag == "Drone") {
            isDroneInside = false;
        }
    }
}
