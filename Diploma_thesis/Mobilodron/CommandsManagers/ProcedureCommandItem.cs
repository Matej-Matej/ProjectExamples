using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ProcedureCommandItem : MonoBehaviour
{

    public int containerIndex = 0;
    CurrentCommandManager commandManager;

    private void Start()
    {
        commandManager = GameObject.Find("CurrentCommandManager").GetComponent<CurrentCommandManager>();
    }

    public void openContainer()
    {
        if (containerIndex < commandManager.getOtherContainers().Count)
        {
            commandManager.getOtherContainers()[containerIndex].gameObject.SetActive(true);
            commandManager.getOtherContainers()[containerIndex].setActiveContainer(true);
        }
    }
}
