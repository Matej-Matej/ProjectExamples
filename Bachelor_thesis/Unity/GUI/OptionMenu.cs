using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class OptionMenu : MonoBehaviour
{

    [SerializeField] private Toggle sound;
    [SerializeField] private Toggle music;
    [SerializeField] private Toggle fullScreen;
    private GameState state;
    // Start is called before the first frame update
    void Start()
    {
        this.state = FindObjectsOfType<GameState>()[0];
        this.sound.isOn = this.state.SoundEffect;
        this.music.isOn = this.state.MusicEffect;
        this.fullScreen.isOn = this.state.FullScreen;

        this.sound.onValueChanged.AddListener(delegate
        {
            soundToggle(this.sound);
        });

        this.music.onValueChanged.AddListener(delegate
        {
            musicToggle(this.music);
        });

        this.fullScreen.onValueChanged.AddListener(delegate
        {
            fullScreenToggle(this.fullScreen);
        });

    }

    public void fullScreenToggle(Toggle fullScreen)
    {
        this.fullScreen.isOn = fullScreen.isOn;
        this.state.FullScreen = this.fullScreen.isOn;
        Screen.fullScreen = this.fullScreen.isOn;
    }

    public void soundToggle(Toggle sound)
    {
        this.sound.isOn = sound.isOn;
        this.state.SoundEffect = this.sound.isOn;
        this.state.IsUpdated = true;
    }

    public void musicToggle(Toggle music)
    {
        this.music.isOn = music.isOn;
        this.state.MusicEffect = this.music.isOn;
        this.state.IsUpdated = true;
    }

    public void saveState()
    {
        this.state.saveGameState();
    }

}
