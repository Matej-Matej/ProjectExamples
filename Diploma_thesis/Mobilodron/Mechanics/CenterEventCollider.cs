using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CenterEventCollider : MonoBehaviour
{

    public ConditionRightEnum currentEvent = ConditionRightEnum.NONE;

    private void OnTriggerEnter(Collider other)
    {
        MainGame.currentSign = currentEvent;
    }

    public void restart() {
         MainGame.currentSign = ConditionRightEnum.NONE;
         currentEvent = ConditionRightEnum.NONE;
    }
}
