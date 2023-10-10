using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StartSandboxManager : MonoBehaviour
{

    public Transform allCommandsPanel;
    public GameObject sandBoxCommands;

    public void startSandbox()
    {
        MainGame.sandboxEnabled = true;
        sandBoxCommands.SetActive(true);
        makePlusAndMinusButtonsVisible();
    }

    public void makePlusAndMinusButtonsVisible()
    {
        foreach (Transform child in allCommandsPanel)
        {
            child.transform.Find("PlusButton").gameObject.SetActive(true);
            child.transform.Find("MinusButton").gameObject.SetActive(true);
        }
    }
}
