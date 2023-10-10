using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class LevelSelectManager : MonoBehaviour
{

    public void backToMenu()
    {
        SceneManager.LoadScene("MainMenu");
    }

    public void switchToLevel(string levelNumber)
    {
       SceneManager.LoadScene("Level_"+levelNumber);
    }

    // normalne sa restartne cely level, zmazu sa vsetky command a pod.
    public void resetLevel()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().name);
    }

    // iba zacina od znovu
    public void fakeRestart()
    {
        MainGame.GetCurrentCommandManager().stopPerforming();
        MainGame.closeGameOverScreen();
    }

    public void switchToNextLevel()
    {
        if (SceneManager.sceneCountInBuildSettings > SceneManager.GetActiveScene().buildIndex + 1)
        {
            SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex + 1);
        }
    }

}
