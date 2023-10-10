using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TutorialLevel1Manager : MonoBehaviour
{
    public TutorialTextManager tutorialTextManager;
    public GameObject allCmd;
    public GameObject controlButton;
    // Start is called before the first frame update

    public GameObject cameraArrow;
    public GameObject scrollArrow;
    public GameObject commandArrow;
    public GameObject questArrow;
    public GameObject controlArrow;

    public GameObject objectivePerson;

    void Start()
    {
        allCmd.SetActive(false);
        controlButton.SetActive(false);

        cameraArrow.SetActive(false);
        scrollArrow.SetActive(false);
        commandArrow.SetActive(false);
        questArrow.SetActive(false);
        controlArrow.SetActive(false);

        objectivePerson.SetActive(false);

        tutorialTextManager.start();
    }

    // Update is called once per frame
    void Update()
    {
        switch(tutorialTextManager.getTextArrayIndex())
        {
            case 3:
                cameraArrow.SetActive(true);
                controlButton.SetActive(true);
                break;
            case 4:
                cameraArrow.SetActive(false);
                commandArrow.SetActive(true);
                allCmd.SetActive(true);
                break;
            case 5:
                commandArrow.SetActive(false);
                break;
            case 6:
                break;
            case 7:
                controlArrow.SetActive(true);
                controlButton.SetActive(true);
                break;
            case 8:
                controlArrow.SetActive(false);
                objectivePerson.SetActive(true);
                break;
            case 9:
                questArrow.SetActive(true);
                break;
            case 10:
                cameraArrow.SetActive(false);
                scrollArrow.SetActive(false);
                commandArrow.SetActive(false);
                questArrow.SetActive(false);
                controlArrow.SetActive(false);

                allCmd.SetActive(true);
                controlButton.SetActive(true);
                objectivePerson.SetActive(true);

                tutorialTextManager.hideGameObject();
                break;
        }
    }
}
