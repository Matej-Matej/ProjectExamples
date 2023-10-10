using System.Collections;
using UnityEngine;
using UnityEngine.UI;

public class CurrentCommandContainer : Container
{
    void Start()
    {
        base.initialize();
    }
    /*
     * Cisto len kvoli tutorialu 
     */
    public bool containForward()
    {
        for (var i = 0; i < usedCommands.Count; i++)
        {
            if (usedCommands[i].name == "ForwardCmd")
            {
                return true;
            }
        }
        return false;
    }

    public bool emptyUsedCommands()
    {
        foreach (Transform child in contentRef.transform) {
            return false;
        }
        return true;
    }

    public override void removeAtPosition(int position)
    {
        if (!MainGame.getPerformingCommands())
        {
            if (usedCommands[position] != null)
            {
                usedCommands[position].numberOfUse++;
                usedCommands.RemoveAt(position);
                changeChildIndex(position);
            }
        }
    }
    public override void resetAllCommands()
    {
        foreach (Transform child in contentRef.transform)
        {
            child.GetComponent<CurrentCommandItem>().removeItemWithContainers();
        }
    }

    public void changeChildIndex(int deletedIndex)
    {
        foreach (Transform child in contentRef.transform)
        {
            int childItemIndex = child.gameObject.GetComponent<CurrentCommandItem>().getItemIndex();
            if (childItemIndex > deletedIndex)
            {
                child.gameObject.GetComponent<CurrentCommandItem>().setItemIndex(childItemIndex - 1);
            }
        }
    }
    public override IEnumerator performAll()
    {
        for (var j = 0; j < numberOfLoops; j++)
        {
            for (var i = 0; i < usedCommands.Count; i++)
            {
                float timeToPerformCommand = MainGame.timeToPerformCommand;
                if (usedCommands[i].getContainContainer() || usedCommands[i].getCommandType() == TypesEnum.PROCEDURE)
                {
                    foreach (Transform child in contentRef.transform)
                    {
                        if (child.gameObject.GetComponent<CurrentCommandItem>().getItemIndex() == i)
                        {
                            yield return commandManager.getOtherContainers()[child.gameObject.GetComponent<CurrentCommandItem>().getContainerIndex()].performAll();
                        }
                    }
                }
                else
                {
                    contentRef.transform.GetChild(i).GetComponent<CurrentCommandItem>().used();
                    usedCommands[i].performAction(timeToPerformCommand);
                    yield return new WaitForSeconds(timeToPerformCommand);
                    contentRef.transform.GetChild(i).GetComponent<CurrentCommandItem>().notUsed();
                }
                yield return new WaitForSeconds(0);

            }
        }
    }
}
