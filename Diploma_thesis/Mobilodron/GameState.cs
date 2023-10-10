using System.IO;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;


public class GameState : MonoBehaviour
{

    private bool soundEffect = true;
    private bool musicEffect = true;
    private bool soundUpdated = false;
    private bool musicUpdated = false;
    private string lastLevelName = "Level_1";
    private ScoreRecord[] highScore;

    private string save_name = "savegame.save";
    private string score_name = "score.save";
    private string game_state_path;
    private string score_path;
    private string saveDirectory;

    public void Awake()
    {
        Screen.fullScreen = true;
        saveDirectory = Application.dataPath + "/Saves/";
        game_state_path = Application.dataPath + "/Saves/" + save_name;
        score_path = Application.dataPath + "/Saves/" + score_name;
    }

    // Start is called before the first frame update
    public void Start()
    {
        if (!Directory.Exists(saveDirectory))
        {
            Directory.CreateDirectory(saveDirectory);
        }
        loadGameState();
        loadScore();
        int numberOfObjects = FindObjectsOfType<GameState>().Length;
        if (numberOfObjects > 1)
        {
            Destroy(gameObject);
        }
        else
        {
            DontDestroyOnLoad(gameObject);
        }
    }

    public void restartGame()
    {
        if (Directory.Exists(saveDirectory))
        {
            Directory.Delete(saveDirectory, true);
            Directory.CreateDirectory(saveDirectory);
        }

        this.soundEffect = false;
        this.musicEffect = false;
        this.lastLevelName = "Level_1";
        saveGameState();
    }

    public void saveGameState()
    {
        SaveObject saveData = new SaveObject()
        {
            soundEffect = this.soundEffect,
            musicEffect = this.musicEffect,
            lastLevel = this.lastLevelName
        };
        string save = JsonUtility.ToJson(saveData);
        File.WriteAllText(game_state_path, save);
    }

    public void loadGameState()
    {
        if (File.Exists(game_state_path))
        {
            string saveString = File.ReadAllText(game_state_path);
            if (saveString != "")
            {
                SaveObject saveObject = JsonUtility.FromJson<SaveObject>(saveString);
                this.soundEffect = saveObject.soundEffect;
                this.musicEffect = saveObject.musicEffect;
                this.lastLevelName = saveObject.lastLevel;
            }
        }
    }

    public void saveScore()
    {
        ScoreObject saveData = new ScoreObject();
        saveData.convertToString(highScore);
        string save = JsonUtility.ToJson(saveData);
        File.WriteAllText(score_path, save);
    }

    public void loadScore()
    {
        if (File.Exists(score_path))
        {
            string saveString = File.ReadAllText(score_path);
            if (saveString != "")
            {
                ScoreObject saveObject = JsonUtility.FromJson<ScoreObject>(saveString);
                saveObject.convertFromString(this.highScore);
            }
        }
    }

    public string transferToString()
    {
        loadScore();
        var text = "";
        if (highScore.Length > 0)
            for (int i = 0; i < highScore.Length - 1; i++) text += highScore[i].scorePrint();
        return text;
    }

    public bool SoundEffect
    {
        get
        {
            return soundEffect;
        }

        set
        {
            soundEffect = value;
            soundUpdated = true;
            saveGameState();
        }
    }

    public bool MusicEffect
    {
        get
        {
            return musicEffect;
        }

        set
        {
            musicEffect = value;
            musicUpdated = true;
            saveGameState();
        }
    }

    public bool MusicUpdated
    {
        get
        {
            return musicUpdated;
        }

        set
        {
            musicUpdated = value;
        }
    }

    public bool SoundUpdated
    {
        get
        {
            return soundUpdated;
        }

        set
        {
            soundUpdated = value;
        }
    }

    public string LastLevelName
    {
        get
        {
            return lastLevelName;
        }

        set
        {
            lastLevelName = value;
            saveGameState();
        }
    }

    private class SaveObject
    {
        public bool soundEffect;
        public bool musicEffect;
        public bool fullScreen;
        public string lastLevel;
    }

    private class ScoreObject
    {
        public int minScore;
        public string convertedScore = "";

        public string convertToString(ScoreRecord[] highScore)
        {
            for (int i = 0; i < highScore.Length; i++)
            {
                convertedScore += highScore[i].scoreValue + "�" + highScore[i].scoreName + "�";
            }
            return convertedScore;
        }
        public void convertFromString(ScoreRecord[] highScore)
        {
            string[] words = convertedScore.Split('�');
            for (int i = 0; i < highScore.Length; i++)
            {
                highScore[i].scoreValue = Int32.Parse(words[2 * i]);
                highScore[i].scoreName = words[(2 * i) + 1];
            }
        }
    }

    private class ScoreRecord
    {
        public int scoreValue;
        public string scoreName;

        public ScoreRecord(int value, string name)
        {
            scoreValue = value;
            scoreName = name;
        }

        public String scorePrint()
        {
            return "     " + scoreValue + "     " + scoreName + "\n";
        }
    }
}
