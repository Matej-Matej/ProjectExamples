using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class MainGame : MonoBehaviour
{
    /*
     * Trieda sluzi k vytvoreniu statickej premennej na dron, ku ktoremu budeme moct pristupovat z ostatnych skriptov
     */

    static public GameObject droneObject = null;
    static public GameObject gameStateWin = null;
    static public GameObject gameStateLose = null;
    static public CurrentCommandManager currentCommandManager = null;
    static public CurrentCommandContainer currentCommandContainer = null;

    static public DroneVariables droneVariables = null;

    static public bool performingCommands = false;

    static public float timeToPerformCommand = 0.1f;

    static public ConditionRightEnum currentSign;

    static public bool sandboxEnabled = false;


    void Start()
    {
        droneObject = GameObject.FindGameObjectWithTag("Drone");
        gameStateWin = GameObject.FindGameObjectWithTag("GameStateWin");
        gameStateLose = GameObject.FindGameObjectWithTag("GameStateLose");
        droneVariables = GameObject.FindGameObjectWithTag("DroneVariables").GetComponent<DroneVariables>();
        droneVariables.gameObject.SetActive(false);
        currentCommandManager = GameObject.FindObjectOfType<CurrentCommandManager>();
        currentCommandContainer = currentCommandManager.getMainContainer(); 
        gameStateWin.SetActive(false);
        gameStateLose.SetActive(false);
        GameState[] gameStates = FindObjectsOfType<GameState>();
        if (gameStates.Length > 0)
        {
            GameState gameState = gameStates[0];

            if (SceneManager.GetActiveScene().name.Length == gameState.LastLevelName.Length)
            {
                if (SceneManager.GetActiveScene().name.CompareTo(gameState.LastLevelName) > 0)
                {
                    gameState.LastLevelName = SceneManager.GetActiveScene().name;
                }
            }
            else
            {
                if (SceneManager.GetActiveScene().name.Length > gameState.LastLevelName.Length)
                {
                    gameState.LastLevelName = SceneManager.GetActiveScene().name;
                }
            }
        }
    }

    // vracia skript na drona
    static public DroneMovement GetDroneMovement()
    {
        return droneObject.GetComponent<DroneMovement>();
    }

    static public DroneVariables GetDroneVariables()
    {
        return droneVariables;
    }

    static public CargoDetector GetCargoDetector()
    {
        return droneObject.GetComponentInChildren <CargoDetector>();
    }

    static public CurrentCommandManager GetCurrentCommandManager()
    {
        return currentCommandManager;
    }

    static public bool getPerformingCommands()
    {
        return performingCommands;
    }

    static public void setPerformingCommands(bool newValue)
    {
        performingCommands = newValue;
    }

    static public void resetAll()
    {
        setPerformingCommands(false);
        GetDroneMovement().changeDroneColor.restartColor();
        GetDroneMovement().resetDroneTransform();
        GetCargoDetector().resetCargoDetector();
        GetDroneVariables().restartVariables();
        currentSign = ConditionRightEnum.NONE;
        GameObject[] allCargos = GameObject.FindGameObjectsWithTag("Cargo");
        foreach (GameObject cargo in allCargos)
        {
            if (cargo.GetComponent<CargoManager>() != null)
            {
                cargo.GetComponent<CargoManager>().resetCargo();
            }
        }
    }

    public static void gameOverScreen(string text)
    {
        if (gameStateLose != null)
        {
            currentCommandManager.stopPerforming();
            gameStateLose.SetActive(true);
            if (gameStateLose.transform.Find("LoseReason") != null)
            {
                gameStateLose.transform.Find("LoseReason").GetComponent<Text>().text = text;
            }
        } 
        else
        {
            Debug.LogError("GameStateLose is null.");
        }
    }

    public static void closeGameOverScreen()
    {
        if (gameStateLose != null)
        {
            gameStateLose.SetActive(false);
        }
        else
        {
            Debug.LogError("GameStateLose is null.");
        }
    }

    public static void openWinScreen(string winningText)
    {
        if (gameStateWin != null)
        {
            gameStateWin.SetActive(true);
            gameStateWin.GetComponent<GameStateWinHandler>().changeWinText(winningText);         
        }
        else
        {
            Debug.LogError("GameStateWin is null.");
        }
    }

    public static void collidingWithPaperChecker()
    {

    }

}
