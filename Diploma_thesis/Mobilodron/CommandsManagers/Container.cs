using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;

public class Container : MonoBehaviour
{

    public List<Command> usedCommands = new List<Command>();
    public TypesEnum typeOfContainer = TypesEnum.NORMAL;

    public int numberOfLoops = 1; // pocet opakovani prikazov

    public bool mainContainer = false;
    public bool activeContainer = false;

    public Button setActiveButtonRef = null;
    public GameObject contentRef = null; // odkaz na miesto, kde sa budu ukladat prikazy
    public Button hideButtonRef = null;
    public Button moveButtonRef = null;

    public CurrentCommandManager commandManager;

    public Container currentCommandContainerRef = null;
    public Container conditionCommandContainerRef = null;
    public Container whileLoopCommandContainerRef = null;
    public Container variableCommandContainerRef = null;

    public bool canPutItems = true;

    private Vector3 dragOffset;

    public virtual void resetWholeContainer()
    {
        usedCommands.Clear();
        numberOfLoops = 1;
        mainContainer = false;
        canPutItems = true;
        typeOfContainer = TypesEnum.NORMAL;
        setActiveContainer(true);
        foreach (Transform child in contentRef.transform)
        {
            GameObject.Destroy(child.gameObject);
        }
        initialize();
    }

    public virtual void addContainer(Container newContainer)
    {
        commandManager.addContainer(newContainer);
    }
    public virtual void initialize()
    {
        commandManager =  GameObject.Find("CurrentCommandManager").GetComponent<CurrentCommandManager>();
        if (mainContainer)
        {
            setActiveContainer(true);
            hideButtonRef.gameObject.SetActive(false);
            moveButtonRef.gameObject.SetActive(false);
        }
        else
        {
            moveButtonRef.gameObject.SetActive(true);
            hideButtonRef.gameObject.SetActive(true);
        }
    }
    public virtual void hideContainer()
    {
        setActiveContainer(false);
        gameObject.SetActive(false);
        if (commandManager != null)
        {
            commandManager.findContainer(true, false);
        }
    }

    public virtual void dragStart(BaseEventData data)
    {
        setActiveContainer(true);
        dragOffset = (Input.mousePosition - transform.position);
    }
    public virtual void dragContainer(BaseEventData data)
    {
        Vector3 pos = Input.mousePosition;
        pos -= dragOffset;
        transform.position = pos;
    }
    public virtual bool isMainContainer()
    {
        return mainContainer;
    }
    public virtual bool isActiveContainer()
    {
        return activeContainer;
    }

    public virtual TypesEnum getTypeOfContainer()
    {
        return typeOfContainer;
    }

    public virtual void setTypeOfContainer(TypesEnum newType)
    {
        typeOfContainer = newType;
    }

    public virtual List<Command> getUsedCommands()
    {
        return usedCommands;
    }

    public virtual void add(Command cmd, CurrentCommandItem currentCommandItem)
    {
        if (getTypeOfContainer() == TypesEnum.PROCEDURE && (cmd.gameObject.name == "Procedure" || cmd.gameObject.name == "Procedure2")) {
            cmd.numberOfUse += 1;
            return ;
        }
        CurrentCommandItem newChild = (CurrentCommandItem)Instantiate(currentCommandItem, transform.position, transform.rotation, contentRef.transform);
        usedCommands.Add(cmd);

        newChild.setItemIndex(usedCommands.Count - 1);
        newChild.changeSprite(cmd.cmdIcon);
        newChild.isLoop(cmd.getCommandType() == TypesEnum.LOOP, cmd.getNumberOfLoops());

        if (cmd.getCommandType() == TypesEnum.PROCEDURE)
        {
            ProcedureCmd proc = cmd as ProcedureCmd;
            newChild.setContainerIndex(proc.containerIndex);
        }
        else if (cmd.getContainContainer())
        {
            Container newContainer = null;
            if (cmd.getCommandType() == TypesEnum.CONDITION)
            {
                newContainer = Instantiate(conditionCommandContainerRef, new Vector3(0, 0, 0), transform.rotation, transform.parent.transform) as ConditionCommandContainer;
                newContainer.resetWholeContainer();
                newContainer.canPutItems = false;
                newContainer.addConditionContainers();
            } else if (cmd.getCommandType() == TypesEnum.WHILE_LOOP)
            {
                newContainer = Instantiate(whileLoopCommandContainerRef, new Vector3(0, 0, 0), transform.rotation, transform.parent.transform) as WhileLoopCommandContainer;
                newContainer.resetWholeContainer();
                newContainer.canPutItems = false;
                newContainer.addConditionContainers();
            } else if (cmd.getCommandType() == TypesEnum.VARIABLE)
            {
                newContainer = Instantiate(variableCommandContainerRef, new Vector3(0, 0, 0), transform.rotation, transform.parent.transform) as VariableCommandContainer;
                newContainer.resetWholeContainer();
                newContainer.canPutItems = false; 
                newContainer.addConditionContainers();
            } else
            {
                newContainer = Instantiate(currentCommandContainerRef, new Vector3(0, 0, 0), transform.rotation, transform.parent.transform);
                newContainer.resetWholeContainer();
            }
            newContainer.numberOfLoops = cmd.getNumberOfLoops();
            newContainer.transform.localPosition = new Vector3(0, 0, 0);
            newContainer.setTypeOfContainer(cmd.getCommandType());
            addContainer(newContainer);
            newChild.setContainerIndex(commandManager.getOtherContainers().Count - 1);

        }
    }

    public virtual void addConditionContainers()
    {

    }
    public virtual void removeAtPosition(int position)
    {

    }
    public virtual void resetAllCommands()
    {

    }
    public virtual IEnumerator performAll()
    {
        return null;
    }
    public virtual void setActiveContainer(bool value)
    {
        if (value)
        {
            GameObject[] allContainers = GameObject.FindGameObjectsWithTag("CmdContainer");
            if (allContainers.Length > 0)
            {
                for (int i = 0; i < allContainers.Length; i++)
                {
                    allContainers[i].GetComponent<Container>().setActiveContainer(false);
                }
            }
            transform.SetAsLastSibling();
        }
        setActiveButtonRef.gameObject.SetActive(!value);
        activeContainer = value;
    }

    public virtual void openOtherContainer(int containerIndex)
    {
        if (containerIndex < commandManager.getOtherContainers().Count)
        {
            commandManager.getOtherContainers()[containerIndex].gameObject.SetActive(true);
            commandManager.getOtherContainers()[containerIndex].setActiveContainer(true);
        }
    }
}
