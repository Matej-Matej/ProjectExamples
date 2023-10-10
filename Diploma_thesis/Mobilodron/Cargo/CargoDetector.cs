using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CargoDetector : MonoBehaviour
{

    private bool pickCargo = false;
    // Start is called before the first frame update

    public void OnTriggerStay(Collider other)
    {
        if (other.tag == "Cargo")
        {
            other.gameObject.GetComponent<CargoManager>().setIsPicked(pickCargo);
        }
    }

    public bool getPickCargo()
    {
        return pickCargo;
    }

    public void setPickCargo(bool pickValue)
    {
        pickCargo = pickValue;
    }

    public void resetCargoDetector()
    {
        pickCargo = false;
    }

}
