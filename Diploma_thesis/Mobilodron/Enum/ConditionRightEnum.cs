using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum ConditionRightEnum
{
    NONE,
    // POZRI POD
    FLOWERS,
    CARGO,
    // ZNACKY
    LEFT_SIGN,
    RIGHT_SIGN,
    FORWARD_SIGN,

    // RYCHLOST
    S20,
    S40,
    S50,

    // SVETLA , POM
    LIGHTS_TRUE,
    LIGHTS_FALSE,

    // FARBA
    COLOR_RED,
    COLOR_BLUE,
    COLOR_YELLOW

}

public static class ConditionRightEnumExtension
{
    public static string ToFriendlyString(this ConditionRightEnum me)
    {
        switch (me)
        {
            case ConditionRightEnum.FLOWERS:
                return "Kvety";
            case ConditionRightEnum.CARGO:
                return "Naklad";
            case ConditionRightEnum.LEFT_SIGN:
                return "Znacka vlavo";
            case ConditionRightEnum.RIGHT_SIGN:
                return "Znacka vpravo";
            case ConditionRightEnum.FORWARD_SIGN:
                return "Znacka dopredu";
            case ConditionRightEnum.S20:
                return "20";
            case ConditionRightEnum.S40:
                return "40";
            case ConditionRightEnum.S50:
                return "50";
            case ConditionRightEnum.LIGHTS_TRUE:
                return "Zapnut";
            case ConditionRightEnum.LIGHTS_FALSE:
                return "Vypnut";
            case ConditionRightEnum.COLOR_RED:
                return "Cervena";
            case ConditionRightEnum.COLOR_BLUE:
                return "Modra";
            case ConditionRightEnum.COLOR_YELLOW:
                return "Zlta";
            default:
                return "";
        }
    }
}
