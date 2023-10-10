using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CreateConditionMechanic : MonoBehaviour
{

    public List<ConditionLeftSide> allConditions;
    public Dropdown leftSide;
    public Dropdown middleSide;
    public Dropdown rightSide;

    // Start is called before the first frame update
    void Start()
    {
        setLeftSide();
    }

    public void setLeftSide()
    {
        for (int i = 0; i < allConditions.Count; i++)
        {
            string name = allConditions[i].getNameOfTheCondition();
            leftSide.AddOptions(new List<string> { name });
        }
        setMiddleSide();
    }

    public void setMiddleSide()
    {
        middleSide.ClearOptions();
        List<ConditionMiddleEnum> mid = allConditions[leftSide.value].GetConditionMiddleEnums();
        for (int m = 0; m < mid.Count; m++)
        {
            string name = ConditionMiddleEnumExtension.ToFriendlyString(mid[m]);
            middleSide.AddOptions(new List<string> { name });
        }
        rightSide.gameObject.SetActive(true);

        setRightSide();
    }

    public void setRightSide()
    {
        rightSide.ClearOptions();
        List<ConditionRightEnum> rig = allConditions[leftSide.value].GetConditionRightEnums();
        for (int r = 0; r < rig.Count; r++)
        {
            string name = ConditionRightEnumExtension.ToFriendlyString(rig[r]);
            rightSide.AddOptions(new List<string> { name });
        }
    }

    public void onLeftSideValueChanged()
    {
        setMiddleSide();
    }

    public bool evaluateCondition()
    {
        return allConditions[leftSide.value].evaluateCondition(middleSide.value, rightSide.value);
    }

}
