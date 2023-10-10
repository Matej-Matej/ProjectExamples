using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EventMechanics : MonoBehaviour
{
    public Animation animation;
    
    public string loseText;

    public EventCollider centerCollider;
    public EventCollider leftCollider;
    public EventCollider rightCollider;
    public EventCollider forwardCollider;

    private bool performingCommands = false;

    void Start()
    {
        animation.Play("SignAnimationDefault");
        centerCollider.setLoseText(loseText);
        leftCollider.setLoseText(loseText);
        rightCollider.setLoseText(loseText);
        forwardCollider.setLoseText(loseText);
    }

    void Update()
    {
        if (MainGame.performingCommands && !performingCommands)
        {
            performingCommands = true;
        } 
        else if (!MainGame.performingCommands)
        {
            performingCommands = false;
            leftCollider.triggered = false;
            rightCollider.triggered = false;
            forwardCollider.triggered = false;
            centerCollider.triggered = false;
            centerCollider.restart();
        }
    }

}
