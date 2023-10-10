using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CargoManager : MonoBehaviour
{

    private bool isPicked = false;
    public Vector3 cargoPosition;
    public Quaternion cargoRotation;
    // Start is called before the first frame update
    void Start()
    {
        cargoPosition = transform.position;
        cargoRotation = transform.rotation;
    }

    // Update is called once per frame
    void Update()
    {

        if (isPicked)
        {
            transform.position = MainGame.GetDroneMovement().transform.position + new Vector3(0,-0.75f,0);
            transform.rotation = MainGame.GetDroneMovement().transform.rotation;
        }
    }

    public bool getIsPicked()
    {
        return isPicked;
    }

    public void setIsPicked(bool isPickedValue)
    {
        isPicked = isPickedValue;
    }

    public void resetCargo()
    {
        isPicked = false;
        transform.position = cargoPosition;
        transform.rotation = cargoRotation;
    }
}
