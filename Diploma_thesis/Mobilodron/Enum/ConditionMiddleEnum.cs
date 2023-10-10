using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum ConditionMiddleEnum
{
    EQUAL,
    HIGHER,
    LOWER
}

public static class ConditionMiddleEnumExtension
{
    public static string ToFriendlyString(this ConditionMiddleEnum me)
    {
        switch (me)
        {
            case ConditionMiddleEnum.EQUAL:
                return "Rovná sa";
            case ConditionMiddleEnum.HIGHER:
                return "je vacsie ako";
            case ConditionMiddleEnum.LOWER:
                return "je mensie ako";
            default:
                return "";
        }
    }
}
