using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class MenuButtonsManager : MonoBehaviour
{
    public void exitGame()
    {
        Application.Quit();
    }

    public void openCredits()
    {
        SceneManager.LoadScene("Credits");
    }

    public void openChangeDrone()
    {
        SceneManager.LoadScene("ChangeDrone");
    }

    public void startNewGame()
    {
        SceneManager.LoadScene("Level_1");
    }

    public void continueGame()
    {
        SceneManager.LoadScene(FindObjectsOfType<GameState>()[0].LastLevelName);
    }

    public void openLevelSelect()
    {
        SceneManager.LoadScene("LevelSelect");
    }

    public void openOptions()
    {
        SceneManager.LoadScene("Options");
    }
}
