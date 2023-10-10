using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CurrentCommandManager : MonoBehaviour
{
    /* bude spravova� DO ktoreho kontainera sa prida prikaz.
     * Kedze bude viac kontainerov, pri pridani prikazu sa budu volat metody z tejto triedy a ona najde kontainer, kde sa bude prikaz prid�va�.
     * Spustanie prikazov bude riesit jednotlivy kontainer. */

    private float normalSpeed = 0.9f;
    private float fastSpeed = 0.2f;

    [SerializeField]
    private CurrentCommandItem currentCommandItem;

    [SerializeField]
    private Container activeContainer;

    [SerializeField]
    private CurrentCommandContainer mainContainer;

    public List<Container> otherContainers = new List<Container>();

    void Start()
    {
        MainGame.timeToPerformCommand = normalSpeed;
        findContainer(true, true);
    }

    public void addContainer(Container newContainer)
    {
        otherContainers.Add(newContainer);
    }

    public List<Container> getOtherContainers()
    {
        return otherContainers;
    }

    public void setContainer(int position, Container newContainer)
    {
        otherContainers[position] = newContainer;
    }

    public CurrentCommandContainer getMainContainer()
    {
        return mainContainer;
    }

    public void findContainer(bool active = false, bool main = false)
    {
        GameObject[] allContainers = GameObject.FindGameObjectsWithTag("CmdContainer");
        if (active)
        {
            activeContainer = null;
        }
        if (allContainers.Length > 0)
        {
            for (int i = 0; i < allContainers.Length; i++)
            {
                if (active)
                {
                    if (allContainers[i].GetComponent<Container>().isActiveContainer())
                    {
                        activeContainer = allContainers[i].GetComponent<Container>();
                    }
                }
                if (main)
                {
                    if (allContainers[i].GetComponent<Container>().isMainContainer())
                    {
                        mainContainer = allContainers[i].GetComponent<CurrentCommandContainer>();
                    }
                }
            }
            if (active && activeContainer == null)
            {
                activeContainer = allContainers[allContainers.Length - 1].GetComponent<Container>();
                activeContainer.setActiveContainer(true);
                /*
                mainContainer.setActiveContainer(true);
                activeContainer = mainContainer;
                */
            }
        }
    }

    public void add(Command cmd)
    {
        findContainer(true, false);

        if (!MainGame.getPerformingCommands())
        {
            if (activeContainer.canPutItems)
                if (cmd.numberOfUse > 0)
                {
                    cmd.numberOfUse--;
                    activeContainer.add(cmd, currentCommandItem);
                }
        }
    }

    public void startPerforming()
    {
        if (!MainGame.getPerformingCommands())
        {
            MainGame.GetDroneMovement().resetDroneTransform();
            stopPerforming();

            MainGame.setPerformingCommands(true);
            StartCoroutine(performAll());
        }
    }

    public void stopPerforming()
    {
        
        MainGame.resetAll();
        StopAllCoroutines();
    }

    public void speedUpPerforming(Toggle speedUpButton)
    {
        if (speedUpButton.isOn)
        {
            MainGame.timeToPerformCommand = fastSpeed;
        }
        else
        {
            MainGame.timeToPerformCommand = normalSpeed;
        }
    }

    public void resetAllCommands()
    {
        if (!MainGame.getPerformingCommands())
        {
            mainContainer.resetAllCommands();
            for (int i = 0; i < otherContainers.Count; i++)
            {
                if (otherContainers[i] != null)
                {
                    otherContainers[i].resetAllCommands();
                    if (!(otherContainers[i].getTypeOfContainer() == TypesEnum.PROCEDURE))
                    {
                        otherContainers[i] = null;
                    }
                }
            }

            GameObject[] allContainers = GameObject.FindGameObjectsWithTag("CmdContainer");

            if (allContainers.Length > 0)
            {
                for (int i = 0; i < allContainers.Length; i++)
                {
                    if (allContainers[i].GetComponent<CurrentCommandContainer>().isMainContainer())
                    {
                        allContainers[i].GetComponent<CurrentCommandContainer>().setActiveContainer(true);
                    }
                    else
                    {
                        if (!(allContainers[i].GetComponent<CurrentCommandContainer>().getTypeOfContainer() == TypesEnum.PROCEDURE))
                        {
                            Destroy(allContainers[i]);
                        }
                    }
                }
            }
            MainGame.sandboxEnabled = false;
            stopPerforming();
        }
    }

    public IEnumerator performAll()
    {
        yield return mainContainer.performAll();
        MainGame.setPerformingCommands(false);
    }
}
