using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ConditionLeftSide : MonoBehaviour
{

    protected string nameOfTheCondition;
    protected string nameOfTheVariable;
    public List<ConditionMiddleEnum> middleCondition;
    public List<ConditionRightEnum> rightCondition;

    public virtual void addMiddleCondition(ConditionMiddleEnum con)
    {
        middleCondition.Add(con);
    }

    public virtual void addRightCondition(ConditionRightEnum con)
    {
        rightCondition.Add(con);
    }

    public virtual List<ConditionMiddleEnum> GetConditionMiddleEnums()
    {
        return middleCondition;
    }
    public virtual List<ConditionRightEnum> GetConditionRightEnums()
    {
        return rightCondition;
    }

    public virtual bool evaluateCondition(int middleIndex, int rightIndex)
    {
        return false;
    }

    public virtual void changeVariable(int rightIndex)
    {
    }

    public virtual string getNameOfTheCondition()
    {
        return nameOfTheCondition;
    }

    public virtual string getNameOfTheVariable()
    {
        return nameOfTheVariable;
    }
}
