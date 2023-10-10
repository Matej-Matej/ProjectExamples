using System.IO;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class LevelState : MonoBehaviour
{

    private bool blueGem;
    private bool greenGem;
    private bool redGem;
    private bool star;
    private string gameStateDirectory;
    private string gameStatePath;
    private GameState state;

    public bool BlueGem
    {
        get
        {
            return blueGem;
        }

        set
        {
            blueGem = value;
        }
    }

    public bool GreenGem
    {
        get
        {
            return greenGem;
        }

        set
        {
            greenGem = value;
        }
    }

    public bool RedGem
    {
        get
        {
            return redGem;
        }

        set
        {
            redGem = value;
        }
    }

    public bool Star
    {
        get
        {
            return star;
        }

        set
        {
            star = value;
        }
    }


    // Start is called before the first frame update
    void Start()
    {
        this.state = FindObjectsOfType<GameState>()[0];
        this.gameStateDirectory = Application.dataPath + "/Saves/Game/";
        this.gameStatePath = this.gameStateDirectory + "" + SceneManager.GetActiveScene().name + ".save";
        if (!Directory.Exists(this.gameStateDirectory))
        {
            Directory.CreateDirectory(this.gameStateDirectory);
        }
        loadProgress();
        saveProgress();
        this.state.LastLevelName = SceneManager.GetActiveScene().name;
        this.state.saveGameState();
    }

    public void saveProgress()
    {
        LevelStructure saveData = new LevelStructure()
        {
            blueGem = this.blueGem,
            greenGem = this.greenGem,
            redGem = this.redGem,
            score = this.state.Score,
        };
        string save = JsonUtility.ToJson(saveData);
        File.WriteAllText(this.gameStateDirectory + "" + SceneManager.GetActiveScene().name + ".save", save);
    }

    public void loadProgress()
    {
        if (File.Exists(this.gameStatePath))
        {
            string saveString = File.ReadAllText(this.gameStatePath);
            if (saveString != "")
            {
                LevelStructure saveObject = JsonUtility.FromJson<LevelStructure>(saveString);
                this.state.Score = saveObject.score;
            }
        }
        else
        {
        }
    }

    private class LevelStructure
    {
        public bool blueGem;
        public bool greenGem;
        public bool redGem;
        public int score;
    }

}
