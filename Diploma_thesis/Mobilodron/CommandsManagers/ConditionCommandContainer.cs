using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ConditionCommandContainer : Container
{
    public CurrentCommandContainer trueContainer;
    public CurrentCommandContainer falseContainer;

    private int trueContainerIndex;
    private int falseContainerIndex;

    public CreateConditionMechanic createConditionMechanic;

    // Start is called before the first frame update
    void Start()
    {
        base.initialize();
    }

    public void openTrueContainer()
    {
        openOtherContainer(trueContainerIndex);
    }

    public void openCloseContainer()
    {
        openOtherContainer(falseContainerIndex);
    }

    public override void add(Command cmd, CurrentCommandItem currentCommandItem)
    {
        base.add(cmd, currentCommandItem);
    }

    public override void addConditionContainers()
    {
        trueContainerIndex = addContainer();
        falseContainerIndex = addContainer();
    }

    public int addContainer()
    {
        CurrentCommandContainer newContainer = Instantiate(currentCommandContainerRef, new Vector3(0, 0, 0), transform.rotation, transform.parent.transform) as CurrentCommandContainer;
        newContainer.resetWholeContainer();
        newContainer.transform.localPosition = new Vector3(0, 0, 0);
        newContainer.setTypeOfContainer(TypesEnum.NORMAL);
        commandManager.addContainer(newContainer);
        newContainer.hideContainer();
        return (commandManager.getOtherContainers().Count - 1);
    }

    public override void resetAllCommands()
    {
        if (commandManager.getOtherContainers()[trueContainerIndex] != null)
        {
            commandManager.getOtherContainers()[trueContainerIndex].resetAllCommands();
        }
        if (commandManager.getOtherContainers()[falseContainerIndex] != null)
        {
            commandManager.getOtherContainers()[falseContainerIndex].resetAllCommands();
        }
    }

    public override IEnumerator performAll()
    {
        if (createConditionMechanic.evaluateCondition())
        {
            yield return commandManager.getOtherContainers()[trueContainerIndex].performAll();
        }
        else
        {
            yield return commandManager.getOtherContainers()[falseContainerIndex].performAll();
        }
        yield return new WaitForSeconds(0);
    }

}
