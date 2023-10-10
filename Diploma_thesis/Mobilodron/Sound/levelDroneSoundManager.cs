using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class levelDroneSoundManager : MonoBehaviour
{
    public AudioSource audioSource = null;

    private GameState gameState;

    // Start is called before the first frame update
    void Start()
    {
        if (audioSource == null)
        {
            audioSource = gameObject.GetComponent<AudioSource>();
        }

        GameState[] gameStates = FindObjectsOfType<GameState>();
        if (gameStates.Length > 0)
        {
            gameState = FindObjectsOfType<GameState>()[0];
        }
    }


    private void FixedUpdate()
    {
        if (gameState != null && gameState.SoundUpdated)
        {
            if (gameState.SoundEffect)
            {
                audioSource.Play();
            }
            else
            {
                audioSource.Stop();
            }
            gameState.SoundUpdated = false;
        }

        if (MainGame.getPerformingCommands())
        {
            if (!audioSource.isPlaying)
            {
                if (gameState != null && gameState.SoundEffect)
                {
                    audioSource.Play();
                }
            }
        }
        else
        {
            audioSource.Stop();
        }
    }
}
