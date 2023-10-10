using System.Collections;
using System.Collections.Generic;
using UnityEngine.UI;
using UnityEngine;

public class Command : MonoBehaviour
{
    /*
     * Hlavna trieda z ktorej dedia vsetky prikazy
     * 
     */

    public int numberOfUse = 2; // urcuje pocet, kolko krat moze byt dany prikaz pouzity
    public Sprite cmdIcon; // urcuje ikonu konkretneho prikazu
    protected bool containContainer = false;
    protected TypesEnum commandType = TypesEnum.NORMAL;

    // sluzi na inicializaciu premennych, v tomto pripade ak nema ziadnu ikonu, zoberie si ju z komponentu Image
    public virtual void InitializeVariables()
    {
        if (numberOfUse < 0) {
            numberOfUse = 0;
        }
        if (cmdIcon != null)
        {
            gameObject.GetComponent<Image>().sprite = cmdIcon;
        }
        else
        {
            Debug.LogError("Treba pridat Ikonku commandu do " + gameObject.name);
        }
    }

    public virtual TypesEnum getCommandType()
    {
        return commandType;
    }

    // sluzi na vykonanie akcie prikazu
    public virtual void performAction(float time)
    {
    }

    public void addNumberOfLoops()
    {
        numberOfUse++;
        if (numberOfUse > 99)
        {
            numberOfUse = 99;
        }
    }

    public void removeNumberOfLoops()
    {
        numberOfUse--;
        if (numberOfUse < 0)
        {
            numberOfUse = 0;
        }
    }

    public virtual int getNumberOfLoops()
    {
        return 0;
    }

    public bool getContainContainer()
    {
        return containContainer;
    }
}
