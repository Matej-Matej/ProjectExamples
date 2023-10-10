using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CheckSignCondition : ConditionLeftSide
{
    // Start is called before the first frame update
    void Awake()
    {
        nameOfTheCondition = "Znacka: smer";    
        nameOfTheVariable = "Smer";
        addMiddleCondition(ConditionMiddleEnum.EQUAL);
        addRightCondition(ConditionRightEnum.LEFT_SIGN);
        addRightCondition(ConditionRightEnum.RIGHT_SIGN);
        addRightCondition(ConditionRightEnum.FORWARD_SIGN);
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

    public override bool evaluateCondition(int middleIndex, int rightIndex)
    {
        return MainGame.currentSign == rightCondition[rightIndex];
    }

}
