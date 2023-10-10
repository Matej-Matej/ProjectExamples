using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class OptionToggleDefaultValue : MonoBehaviour
{

    public Toggle sound;
    public Toggle music;
    public Toggle fullScreen;

    private GameState gameState;

    // Start is called before the first frame update
    void Start()
    {
        gameState = FindObjectsOfType<GameState>()[0];
        gameState.loadGameState();
        sound.isOn = gameState.SoundEffect;
        music.isOn = gameState.MusicEffect;
    }

    public void restartSave()
    {
        gameState.restartGame();
    }

    public void setMusic(bool value)
    {
        gameState.MusicEffect = value;
    }

    public void setSound(bool value)
    {
        gameState.SoundEffect = value;
    }
}
