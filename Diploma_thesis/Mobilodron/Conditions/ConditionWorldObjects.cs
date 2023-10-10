using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ConditionWorldObjects : MonoBehaviour
{

    public ConditionRightEnum typeOfObject;
    public bool underCollision = false;
    public bool inFrontCollision = false;

    private void OnTriggerEnter(Collider other)
    {
        checkDetection(other.name,true);
    }

    private void OnTriggerExit(Collider other)
    {
        checkDetection(other.name,false);
    }

    private void checkDetection(string otherName,bool isEnter)
    {
        if (otherName == "checkUnderDetector")
        {
            underCollision = isEnter;
        }
        else if (otherName == "checkInFrontDetector")
        {
            inFrontCollision = isEnter;
        }
    }
}
