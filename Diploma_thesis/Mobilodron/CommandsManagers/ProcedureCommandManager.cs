using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ProcedureCommandManager : MonoBehaviour
{
    public ProcedureCommandItem procedureCommandItem;

    public void addProcedureCommand(int containerIndex, Sprite procedureSprite)
    {
        ProcedureCommandItem procItem = Instantiate(procedureCommandItem, transform.position, transform.rotation, transform);
        procItem.containerIndex = containerIndex;
        procItem.gameObject.GetComponent<Image>().sprite = procedureSprite;
    }
}
