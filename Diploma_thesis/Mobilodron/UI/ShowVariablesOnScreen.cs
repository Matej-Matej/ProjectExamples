using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ShowVariablesOnScreen : MonoBehaviour
{

    public DroneVariables droneVariables;

    public GameObject pointer;

    private bool animatingPointer = false;
    private int animatingStep = 1;
    public Image lightsOff;
    public Image lightsOn;
    public Image blueColor;
    public Image redColor;
    public Image yellowColor;

    // Update is called once per frame
    void Update()
    {
        if (pointer != null && droneVariables.getSpeed() < 20) {
            pointer.transform.rotation = new Quaternion();
            if (MainGame.GetDroneMovement().movingForward) {
                pointer.transform.Rotate(new Vector3(0,0,-25));
            } else {
                pointer.transform.Rotate(new Vector3(0,0,0));
            }
        }

        if (pointer != null && animatingPointer) {
            pointer.transform.rotation = new Quaternion();
            if (droneVariables.getSpeed() == 20) {
                pointer.transform.Rotate(new Vector3(0,0,-50));
                if (pointer.transform.rotation == new Quaternion(0,0,-50,0)) {
                    animatingPointer = false;
                }
            }
            else if (droneVariables.getSpeed() == 40) {
                pointer.transform.Rotate(new Vector3(0,0,-120));
                if (pointer.transform.rotation == new Quaternion(0,0,-120,0)) {
                    animatingPointer = false;
                }
            }
            else if (droneVariables.getSpeed() == 50) {
                pointer.transform.Rotate(new Vector3(0,0,-165));
                if (pointer.transform.rotation == new Quaternion(0,0,-165,0)) {
                    animatingPointer = false;
                }
            } else {
                if (MainGame.GetDroneMovement().movingForward) {
                    pointer.transform.Rotate(new Vector3(0,0,-25));
                    if (pointer.transform.rotation == new Quaternion(0,0,-25,0)) {
                         animatingPointer = false;
                    }  
                }
            }
        }

        if (droneVariables.redrawnVariablesOnScreen)
        {
            droneVariables.redrawnVariablesOnScreen = false;
            animatingPointer = true;
            if (lightsOff != null && lightsOn != null)
            {

                if (droneVariables.getLights())
                {
                    lightsOff.gameObject.SetActive(false);
                    lightsOn.gameObject.SetActive(true);
                }
                else
                {
                    lightsOff.gameObject.SetActive(true);
                    lightsOn.gameObject.SetActive(false);
                }
            }

            if (redColor != null && yellowColor != null && blueColor != null)
            {

                if (droneVariables.getColor() == 1)
                {
                    redColor.color = new Color(1, 1, 1, 1f);
                    yellowColor.color = new Color(1, 1, 1, 0.3f);
                    blueColor.color = new Color(1, 1, 1, 0.3f);
                }
                else if (droneVariables.getColor() == 2)
                {
                    yellowColor.color = new Color(1, 1, 1, 1f);
                    redColor.color = new Color(1, 1, 1, 0.3f);
                    blueColor.color = new Color(1, 1, 1, 0.3f);
                }
                else if (droneVariables.getColor() == 3)
                {
                    blueColor.color = new Color(1, 1, 1, 1f);
                    yellowColor.color = new Color(1, 1, 1, 0.3f);
                    redColor.color = new Color(1, 1, 1, 0.3f);
                }
                else
                {
                    redColor.color = new Color(1, 1, 1, 0.3f);
                    yellowColor.color = new Color(1, 1, 1, 0.3f);
                    blueColor.color = new Color(1, 1, 1, 0.3f);
                }
            }
        }
    }
}
