using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CheckColorCondition : ConditionLeftSide
{
    // Start is called before the first frame update
    void Awake()
    {
        nameOfTheCondition = "Znacka: farba";    
        nameOfTheVariable = "Farba";
        addMiddleCondition(ConditionMiddleEnum.EQUAL);
        addRightCondition(ConditionRightEnum.COLOR_BLUE);
        addRightCondition(ConditionRightEnum.COLOR_RED);
        addRightCondition(ConditionRightEnum.COLOR_YELLOW);
    }

    // Update is called once per frame
    void Update()
    {

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
            case ConditionRightEnum.COLOR_BLUE:
                MainGame.GetDroneVariables().setColor(Color.blue);
                break;
            case ConditionRightEnum.COLOR_RED:
                MainGame.GetDroneVariables().setColor(Color.red);
                break;
            case ConditionRightEnum.COLOR_YELLOW:
                MainGame.GetDroneVariables().setColor(Color.yellow);
                break;
            default:
                break;
        }
    }

    public override bool evaluateCondition(int middleIndex, int rightIndex)
    {
        return MainGame.currentSign == rightCondition[rightIndex];
    }
}
