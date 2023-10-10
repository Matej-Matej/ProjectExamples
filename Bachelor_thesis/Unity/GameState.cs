using System.IO;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class GameState : MonoBehaviour
{

    public const int MAX_LIFE = 3;
    public const int NUMBER_OF_SCORES = 5;

    private int lifes = MAX_LIFE;
    private int score = 0;

    private bool soundEffect = false;
    private bool musicEffect = false;
    private bool fullScreen = false;

    private bool isUpdated = false;
    private bool bossLevel = false;
    private string lastLevelName = "";
    private int minScore = 0;
    private ScoreRecord[] highScore;

    private string save_name = "savegame.save";
    private string score_name = "score.save";
    private string game_state_path;
    private string score_path;
    private string saveDirectory;



    public void Awake()
    {
        highScore = new ScoreRecord[NUMBER_OF_SCORES + 1];
        for (int i = 0; i < NUMBER_OF_SCORES + 1; i++) highScore[i] = new ScoreRecord(0, "");
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
        Screen.fullScreen = this.FullScreen;
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

    public void addScore(int addScore)
    {
        this.score += addScore;
        this.isUpdated = true;
    }

    public bool looseLife()
    {
        lifes -= 1;
        this.isUpdated = true;
        return lifes <= 0;
    }

    public bool gainLife()
    {
        lifes += 1;
        this.isUpdated = true;
        if (lifes > MAX_LIFE)
        {
            lifes = 3;
            return false;
        }
        GameObject.Find("Player").GetComponent<Player>().heal();
        if (soundEffect) GetComponent<AudioSource>().Play();
        return true;
 
    }

    public void restartGame()
    {
        lastLevelName = "";
        lifes = MAX_LIFE;
        score = 0;
        if (Directory.Exists(Application.dataPath + "/Saves/Game/"))
        {
            Directory.Delete(Application.dataPath + "/Saves/Game/", true);
            Directory.CreateDirectory(Application.dataPath + "/Saves/Game/");
        }

    }

    public void saveGameState()
    {
        SaveObject saveData = new SaveObject()
        {
            soundEffect = this.soundEffect,
            musicEffect = this.musicEffect,
            fullScreen = this.fullScreen,
            lastLevel = this.lastLevelName,
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
                this.fullScreen = saveObject.fullScreen;
                this.lastLevelName = saveObject.lastLevel;
                this.isUpdated = true;
            }
        }
    }

    public void saveScore()
    {
        ScoreObject saveData = new ScoreObject();
        saveData.minScore = this.minScore;
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
                this.minScore = saveObject.minScore;
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

    public bool isNewScore(int score)
    {
        if (minScore > score) return false;
        return true;
    }

    private void sortFunction() 
    {
        var change = false;
        for (var i = 0; i < highScore.Length; i++)
        {
            change = false;
            for (var j = 0; j < highScore.Length - i - 1; j++)
            {
                if (highScore[j].scoreValue < highScore[j + 1].scoreValue)
                {
                    var value = highScore[j].scoreValue;
                    var name = highScore[j].scoreName;
                    highScore[j].scoreValue = highScore[j + 1].scoreValue;
                    highScore[j].scoreName = highScore[j + 1].scoreName;
                    highScore[j + 1].scoreValue = value;
                    highScore[j + 1].scoreName = name;
                    change = true;
                }
            }
            if (!change) return;
        }
    }

    public void addHighScore(int scoreValue, string scoreName)
    {
        for (int i = 0; i < NUMBER_OF_SCORES; i++)
        {
            if (highScore[i].scoreValue == 0)
            {
                highScore[i].scoreValue = scoreValue;
                highScore[i].scoreName = scoreName;
                sortFunction();
                minScore = highScore[NUMBER_OF_SCORES - 1].scoreValue;
                saveScore();
                return;
            }                
        }
        if (isNewScore(scoreValue))
        {
            highScore[NUMBER_OF_SCORES].scoreValue = scoreValue;
            highScore[NUMBER_OF_SCORES].scoreName = scoreName;
            sortFunction();
            minScore = highScore[NUMBER_OF_SCORES - 1].scoreValue;
            highScore[NUMBER_OF_SCORES].scoreValue = 0;
            highScore[NUMBER_OF_SCORES].scoreName = "";
            saveScore();
        }
    }

    public int Lifes
    {
        get
        {
            return lifes;
        }

        set
        {
            lifes = value;
        }
    }

    public int Score
    {
        get
        {
            return score;
        }

        set
        {
            score = value;
        }
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
        }
    }

    public bool FullScreen
    {
        get
        {
            return fullScreen;
        }

        set
        {
            fullScreen = value;
        }
    }

    public bool IsUpdated
    {
        get
        {
            return isUpdated;
        }

        set
        {
            isUpdated = value;
        }
    }

    public bool BossLevel
    {
        get
        {
            return bossLevel;
        }

        set
        {
            bossLevel = value;
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
                convertedScore += highScore[i].scoreValue + "§" + highScore[i].scoreName + "§";
            }
            return convertedScore;
        }
        public void convertFromString(ScoreRecord[] highScore)
        {
            string[] words = convertedScore.Split('§');
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
