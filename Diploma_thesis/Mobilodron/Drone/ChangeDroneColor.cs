using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChangeDroneColor : MonoBehaviour
{
    public GameObject mainGO;
    public GameObject secondaryGO;

    private MeshRenderer main;
    private MeshRenderer secondary;

    private void Start()
    {
        main = mainGO.GetComponentInChildren<MeshRenderer>();
        secondary = secondaryGO.GetComponentInChildren<MeshRenderer>();
        restartColor();
    }

    public void changeToRed()
    {
        if (main != null)
        {
            main.material.color = Color.red;
            if (secondary != null)
            {
                secondary.material.color = Color.black;
            }
        }        
    }
    public void changeToYellow()
    {
        if (main != null)
        {
            main.material.color = Color.yellow;
            if (secondary != null)
            {
                secondary.material.color = Color.green;
            }
        }      
    }

    public void changeToBlue()
    {
        if (main != null)
        {
            main.material.color = Color.blue;
            if (secondary != null)
            {
                secondary.material.color = Color.white;
            }
        }      
    }

    public void restartColor()
    {
        if (main != null)
        {
            main.material.color = Color.grey;
            if (secondary != null)
            {
                secondary.material.color = Color.green;
            }
        }   
    }
}
