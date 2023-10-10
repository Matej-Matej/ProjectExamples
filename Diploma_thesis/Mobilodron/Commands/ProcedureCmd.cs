using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ProcedureCmd : Command
{
    public ProcedureCommandManager procedureCommandManager;
    public CurrentCommandContainer currentCommandContainerRef;
    public Transform containerParent;
    public int containerIndex;
    void Start()
    {
        base.InitializeVariables();
        containContainer = false;
        commandType = TypesEnum.PROCEDURE;
        procedureCommandManager = GameObject.Find("ProcedureCommandPanel").GetComponent<ProcedureCommandManager>();
        int containerIndex = addContainer();
        procedureCommandManager.addProcedureCommand(containerIndex, cmdIcon);
    }

    public int addContainer()
    {
        CurrentCommandManager commandManager = GameObject.Find("CurrentCommandManager").GetComponent<CurrentCommandManager>();
        CurrentCommandContainer newContainer = Instantiate(currentCommandContainerRef, new Vector3(0, 0, 0), transform.rotation, containerParent);
        newContainer.resetWholeContainer();
        newContainer.transform.localPosition = new Vector3(0, 0, 0);
        newContainer.setTypeOfContainer(TypesEnum.PROCEDURE);
        commandManager.addContainer(newContainer);
        newContainer.hideContainer();
        containerIndex = commandManager.getOtherContainers().Count - 1;
        return (containerIndex);
    }
}
