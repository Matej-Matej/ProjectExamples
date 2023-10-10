using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TutorialTextManager : MonoBehaviour
{
    // Start is called before the first frame update

    public Text text = null;
    private int textArrayIndex = 0;

    public string[] allTexts;

    void Start()
    {
        if (text == null)
        {
            text = gameObject.GetComponentInChildren<Text>();
        }
    }

    public void start()
    {
        if (allTexts[0] != null)
        {
            textArrayIndex = 0;
            text.text = allTexts[0];
        }
    }

    public void hideGameObject()
    {
        gameObject.SetActive(false);
    }

    public void nextText()
    {
        if (getTextArrayIndex() != 5 && getTextArrayIndex() != 6)
        {
            textArrayIndex++;
            if (textArrayIndex < allTexts.Length)
            {
                text.text = allTexts[textArrayIndex];
            }
        }
    }

    public void skipTutorial()
    {
        textArrayIndex = allTexts.Length;
    }

    // Update is called once per frame
    void Update()
    {
        if (getTextArrayIndex() == 5)
        {
            if (MainGame.GetCurrentCommandManager().getMainContainer().containForward())
            {
                textArrayIndex++;
                if (textArrayIndex < allTexts.Length)
                {
                    text.text = allTexts[textArrayIndex];
                }
            }
        }

        if (getTextArrayIndex() == 6)
        {
            if (MainGame.GetCurrentCommandManager().getMainContainer().emptyUsedCommands())
            {
                textArrayIndex++;
                if (textArrayIndex < allTexts.Length)
                {
                    text.text = allTexts[textArrayIndex];
                }
            }
        }

        if (Input.GetKeyDown(KeyCode.N))
        {
            skipTutorial();
        }
    }

    public int getTextArrayIndex()
    {
        return textArrayIndex;
    }
}
