using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CheckUnderCondition : ConditionLeftSide
{
    // Start is called before the first frame update
    void Awake()
    {
        nameOfTheCondition = "Pozri pod";
        addMiddleCondition(ConditionMiddleEnum.EQUAL);
        addRightCondition(ConditionRightEnum.CARGO);
        addRightCondition(ConditionRightEnum.FLOWERS);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
    public override string getNameOfTheCondition()
    {
        return base.getNameOfTheCondition();
    }
    public override List<ConditionMiddleEnum> GetConditionMiddleEnums()
    {
        return base.GetConditionMiddleEnums();
    }

    public override List<ConditionRightEnum> GetConditionRightEnums()
    {
        return base.GetConditionRightEnums();
    }

    public override bool evaluateCondition(int middleIndex, int rightIndex)
    {
        ConditionMiddleEnum mid = middleCondition[middleIndex];
        ConditionRightEnum rig = rightCondition[rightIndex];

        GameObject[] worldObjects = GameObject.FindGameObjectsWithTag("conditionWorldObject");
        foreach (GameObject w in worldObjects)
        {
            ConditionWorldObjects worldObj = w.GetComponentInChildren<ConditionWorldObjects>();
            if (worldObj.underCollision)
            {
                switch (mid)
                {
                    case ConditionMiddleEnum.EQUAL:
                        if (worldObj.typeOfObject == rig)
                        {
                            return true;
                        }
                        break;
                    default:
                        break;
                }
            }
        }
        return false;
    }
}
