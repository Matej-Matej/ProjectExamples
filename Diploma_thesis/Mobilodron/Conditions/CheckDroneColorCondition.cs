using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CheckDroneColorCondition : ConditionLeftSide
{
    // Start is called before the first frame update
    void Awake()
    {
        nameOfTheCondition = "Premenna: farba";    
        nameOfTheVariable = "Farba";
        addMiddleCondition(ConditionMiddleEnum.EQUAL);
        addRightCondition(ConditionRightEnum.COLOR_BLUE);
        addRightCondition(ConditionRightEnum.COLOR_RED);
        addRightCondition(ConditionRightEnum.COLOR_YELLOW);
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

    public override bool evaluateCondition(int middleIndex, int rightIndex)
    {
        ConditionRightEnum rig = rightCondition[rightIndex];

        switch (rig)
        {
            case ConditionRightEnum.COLOR_BLUE:
                return MainGame.GetDroneVariables().isBlue();
            case ConditionRightEnum.COLOR_RED:
                return MainGame.GetDroneVariables().isRed();
            case ConditionRightEnum.COLOR_YELLOW:
                return MainGame.GetDroneVariables().isYellow();
            default:
                return false;
        }
    }
}
