using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WhileLoopCommandContainer : Container
{
    public CurrentCommandContainer trueContainer;

    private int trueContainerIndex;

    public CreateConditionMechanic createConditionMechanic;

    // Start is called before the first frame update
    void Start()
    {
        base.initialize();
    }

    // Update is called once per frame
    void Update()
    {

    }

    public void openTrueContainer()
    {
        openOtherContainer(trueContainerIndex);
    }

    public override void add(Command cmd, CurrentCommandItem currentCommandItem)
    {
        base.add(cmd, currentCommandItem);
    }

    public override void addConditionContainers()
    {
        trueContainerIndex = addContainer();
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
    }

    public override IEnumerator performAll()
    {
        while (createConditionMechanic.evaluateCondition())
        {
            yield return commandManager.getOtherContainers()[trueContainerIndex].performAll();
        }

        yield return new WaitForSeconds(0);
    }

}
