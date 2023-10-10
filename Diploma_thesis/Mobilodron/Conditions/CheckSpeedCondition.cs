using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CheckSpeedCondition : ConditionLeftSide
{
    // Start is called before the first frame update
    void Awake()
    {
        nameOfTheCondition = "Znacka: rychlost";
        nameOfTheVariable = "Rychlost";
        addMiddleCondition(ConditionMiddleEnum.EQUAL);
        addRightCondition(ConditionRightEnum.S20);
        addRightCondition(ConditionRightEnum.S40);
        addRightCondition(ConditionRightEnum.S50);
    }

    public override string getNameOfTheCondition()
    {
        return base.getNameOfTheCondition();
    }
    
    public override string getNameOfTheVariable()
    {
        return base.getNameOfTheVariable();
    }

    public override List<ConditionMiddleEnum> GetConditionMiddleEnums()
    {
        return base.GetConditionMiddleEnums();
    }

    public override List<ConditionRightEnum> GetConditionRightEnums()
    {
        return base.GetConditionRightEnums();
    }

    public override void changeVariable(int rightIndex)
    {
        ConditionRightEnum rig = rightCondition[rightIndex];

        switch (rig)
        {
            case ConditionRightEnum.S20:
                MainGame.GetDroneVariables().setSpeed(20);
                break;
            case ConditionRightEnum.S40:
                MainGame.GetDroneVariables().setSpeed(40);
                break;
            case ConditionRightEnum.S50:
                MainGame.GetDroneVariables().setSpeed(50);
                break;
            default:
                break;
        }
    }

    public override bool evaluateCondition(int middleIndex, int rightIndex)
    {
        ConditionRightEnum rig = rightCondition[rightIndex];
        switch (rig)
        {
            case ConditionRightEnum.S20:
                return MainGame.GetDroneVariables().getSpeed() <= 20;
            case ConditionRightEnum.S40:
                return MainGame.GetDroneVariables().getSpeed() <= 40;
            case ConditionRightEnum.S50:
                return MainGame.GetDroneVariables().getSpeed() <= 50;
            default:
                break;
        }
        return false;
    }
}
