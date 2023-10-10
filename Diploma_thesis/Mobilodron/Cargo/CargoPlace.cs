using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CargoPlace : MonoBehaviour
{
    // Start is called before the first frame update

    public string winningText = "";
    public bool isCargoInside = false;

    // Update is called once per frame
    void Update()
    {
        if (isCargoInside)
        {
            if (!MainGame.getPerformingCommands())
            {
                MainGame.openWinScreen(winningText);
            }
        }
    }

    public void OnTriggerStay(Collider other)
    {
        if (other.tag == "Cargo")
        {
            if (!other.GetComponent<CargoManager>().getIsPicked())
            {
                isCargoInside = true;
            }
        }
    }
}
