using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class newGameContinueGameManager : MonoBehaviour
{

    public Button menuButton;
    public Button conButton;

    // Start is called before the first frame update
    void Start()
    {
        if (FindObjectsOfType<GameState>()[0].LastLevelName != "Level_1")
        {
            menuButton.gameObject.SetActive(false);
            conButton.gameObject.SetActive(true);
        } else
        {
            menuButton.gameObject.SetActive(true);
            conButton.gameObject.SetActive(false);
        }
    }
}
