using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class CurrentCommandItem : MonoBehaviour
{
    public int itemIndex = 0; // Index na prvok v liste, ku ktoremu je tento item vytvoreny
    public int containerIndex = -1;

    public TextMeshProUGUI tmpText;
    private CurrentCommandContainer commandContainer;
    private CurrentCommandManager commandManager;
    public Image imageRef;
    public Button buttonRef;
    public Image activeCommandRef;

    // Start is called before the first frame update
    void Start()
    {
        commandManager = GameObject.Find("CurrentCommandManager").GetComponent<CurrentCommandManager>();
        activeCommandRef.color = new Color(0,0,0,0);
        if (imageRef == null)
        {
            imageRef = gameObject.GetComponent<Image>();
        }

        if (commandContainer == null)
        {
            commandContainer = gameObject.GetComponentInParent<CurrentCommandContainer>();
        }

        if (buttonRef == null)
        {
            buttonRef = gameObject.GetComponentInChildren<Button>();
        }
    }

    // Update is called once per frame
    void Update()
    {
        if (MainGame.getPerformingCommands())
        {
            buttonRef.gameObject.SetActive(false);
        }
        else
        {
            notUsed();
            buttonRef.gameObject.SetActive(true);
        }
    }

    public void isLoop(bool value, int numOfLoops) {
        if (value) {
            tmpText.text = numOfLoops.ToString();
        } else {
            tmpText.text = "";
        }
    }

    public void changeSprite(Sprite newImage)
    {
        imageRef.sprite = newImage;
    }

    // Metoda sluzi na zmazanie prikazu ( zmaze sa aj v liste )
    // tato metoda sa bude volat ked sa klikne na tlacidlo X na prikaze
    public void removeItemWithContainers()
    {
        if (!MainGame.getPerformingCommands())
        {
            if (itemIndex < commandContainer.getUsedCommands().Count)
            {
                bool isProcedure = commandContainer.getUsedCommands()[itemIndex].getCommandType() == TypesEnum.PROCEDURE;
                commandContainer.removeAtPosition(itemIndex);
                if (containerIndex != -1 && !isProcedure)
                {
                    commandManager.getOtherContainers()[containerIndex].resetAllCommands();
                    commandManager.getOtherContainers()[containerIndex].hideContainer();
                    commandManager.setContainer(containerIndex, null);
                }
            }
            Destroy(gameObject);
        }
    }

    public void openOtherContainer()
    {
        if (containerIndex != -1)
        {
            commandContainer.openOtherContainer(containerIndex);
        }
    }

    public void setItemIndex(int newIndex)
    {
        itemIndex = newIndex;
    }
    public int getItemIndex()
    {
        return itemIndex;
    }

    public void setContainerIndex(int newIndex)
    {
        containerIndex = newIndex;
    }

    public int getContainerIndex()
    {
        return containerIndex;
    }
    public void used()
    {
        activeCommandRef.color = new Color(1, 1, 1, 1);
    }

    public void notUsed()
    {
        activeCommandRef.color = new Color(1, 1, 1, 0);
    }
}
