using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RandomEventMechanics : MonoBehaviour
{
    public Animation animation;
    public GameObject randomMechanics;
    public string loseText;

    public GameObject leftBlueS20;
    public GameObject rightRedS40;
    public GameObject forwardYellowS50;

    public TypesOfRandomEvent typeOfEvent;

    public CenterEventCollider centerCollider;
    public EventCollider leftCollider;
    public EventCollider rightCollider;
    public EventCollider forwardCollider;

    public bool useLeft;
    public bool useRight;
    public bool useForward;

    private bool performingCommands = false;

    // Start is called before the first frame update
    void Start()
    {
        animation.Play("SignAnimationDefault");
        hideAllSignsExceptRandom();
        leftCollider.setLoseText(loseText);
        rightCollider.setLoseText(loseText);
        forwardCollider.setLoseText(loseText);
    }

    void hideAllSignsExceptRandom()
    {
        randomMechanics.SetActive(true);
        leftBlueS20.SetActive(false);
        rightRedS40.SetActive(false);
        forwardYellowS50.SetActive(false);
    }

    void setEventTypeToCollisions(TypesOfRandomEvent ev) {
        rightCollider.typeOfEvent = ev;
        leftCollider.typeOfEvent = ev;
        forwardCollider.typeOfEvent = ev;
    }

    void chooseRandomSign() {
        if (typeOfEvent == TypesOfRandomEvent.DIRECTION) {
            chooseRandomDirectionSign();
        } else if (typeOfEvent == TypesOfRandomEvent.COLOR) {
            chooseRandomColorSign();
        } else if (typeOfEvent == TypesOfRandomEvent.SPEED) {
            chooseRandomSpeedSign();
        }
    }

    void chooseRandomDirectionSign()
    {
        setEventTypeToCollisions(TypesOfRandomEvent.DIRECTION);
        bool foundSign = false;
        while (!foundSign)
        {
            int num = Random.Range(0,3);
            if (num == 1)
            {
                if (useLeft)
                {
                    foundSign = true;
                    leftBlueS20.SetActive(true);
                    randomMechanics.SetActive(false);
                    rightCollider.canWalk = false;
                    forwardCollider.canWalk = false;
                    leftCollider.canWalk = true;
                    centerCollider.currentEvent = ConditionRightEnum.LEFT_SIGN;
                }
            } else if (num == 2)
            {
                if (useRight)
                {
                    foundSign = true;
                    rightRedS40.SetActive(true);
                    randomMechanics.SetActive(false);
                    leftCollider.canWalk = false;
                    forwardCollider.canWalk = false;
                    rightCollider.canWalk = true;
                    centerCollider.currentEvent = ConditionRightEnum.RIGHT_SIGN;
                }
            } else
            {
                if (useForward)
                {
                    foundSign = true;
                    forwardYellowS50.SetActive(true);
                    randomMechanics.SetActive(false);
                    leftCollider.canWalk = false;
                    rightCollider.canWalk = false;
                    forwardCollider.canWalk = true;
                    centerCollider.currentEvent = ConditionRightEnum.FORWARD_SIGN;
                }
            }
        }
    }

    void chooseRandomColorSign()
    {
        setEventTypeToCollisions(TypesOfRandomEvent.COLOR);
        bool foundSign = false;
        while (!foundSign)
        {
            int num = Random.Range(0,3);
            if (num == 1)
            {
                foundSign = true;
                leftBlueS20.SetActive(true);
                randomMechanics.SetActive(false);
                rightCollider.checkBlueColor = true;
                leftCollider.checkBlueColor = true;
                forwardCollider.checkBlueColor = true;
                centerCollider.currentEvent = ConditionRightEnum.COLOR_BLUE;
            } else if (num == 2)
            {
                foundSign = true;
                rightRedS40.SetActive(true);
                randomMechanics.SetActive(false);
                rightCollider.checkRedColor = true;
                leftCollider.checkRedColor = true;
                forwardCollider.checkRedColor = true;
                centerCollider.currentEvent = ConditionRightEnum.COLOR_RED;
            } else
            {
                foundSign = true;
                forwardYellowS50.SetActive(true);
                randomMechanics.SetActive(false);
                rightCollider.checkYellowColor = true;
                leftCollider.checkYellowColor = true;
                forwardCollider.checkYellowColor = true;
                centerCollider.currentEvent = ConditionRightEnum.COLOR_YELLOW;
            }
        }
    }

    void chooseRandomSpeedSign()
    {
        setEventTypeToCollisions(TypesOfRandomEvent.SPEED);
        bool foundSign = false;
        while (!foundSign)
        {
            int num = Random.Range(0,3);
            if (num == 1)
            {
                foundSign = true;
                leftBlueS20.SetActive(true);
                randomMechanics.SetActive(false);
                rightCollider.checkSpeed = 20;
                forwardCollider.checkSpeed = 20;
                leftCollider.checkSpeed = 20;
                centerCollider.currentEvent = ConditionRightEnum.S20;
            } else if (num == 2)
            {
                foundSign = true;
                rightRedS40.SetActive(true);
                randomMechanics.SetActive(false);
                rightCollider.checkSpeed = 40;
                forwardCollider.checkSpeed = 40;
                leftCollider.checkSpeed = 40;
                centerCollider.currentEvent = ConditionRightEnum.S40;
            } else
            {
                foundSign = true;
                forwardYellowS50.SetActive(true);
                randomMechanics.SetActive(false);
                rightCollider.checkSpeed = 50;
                forwardCollider.checkSpeed = 50;
                leftCollider.checkSpeed = 50;
                centerCollider.currentEvent = ConditionRightEnum.S50;
            }
        }
    }

    // Update is called once per frame
    void Update()
    {
        if (MainGame.performingCommands && !performingCommands)
        {
            performingCommands = true;
            chooseRandomSign();
        } 
        else if (!MainGame.performingCommands)
        {
            performingCommands = false;
            hideAllSignsExceptRandom();
            setEventTypeToCollisions(TypesOfRandomEvent.NONE);
            leftCollider.restart();
            rightCollider.restart();
            forwardCollider.restart();
            centerCollider.restart();
        }
    }
}
