using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class MainMenu : MonoBehaviour
{


    [SerializeField] GameObject continueGame;
    private GameState state;

    void Start()
    {
        this.state = FindObjectsOfType<GameState>()[0];
    }

    public void startNewGame()
    {
        this.state.restartGame();
        SceneManager.LoadScene("Level_1");
    }

    public void continueExistingGame()
    {
        SceneManager.LoadScene(this.state.LastLevelName);
    }

    public void playGame()
    {
        if (this.state.LastLevelName != "")
        {
            this.gameObject.SetActive(false);
            continueGame.SetActive(true);
        }
        else
        {
            SceneManager.LoadScene("Level_1");
        }
    }
    public void exitGame()
    {
        this.state.saveGameState();
        Application.Quit();
    }

}
