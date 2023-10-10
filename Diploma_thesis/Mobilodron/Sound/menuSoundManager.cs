using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class menuSoundManager : MonoBehaviour
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

            if (gameState.MusicEffect)
            {
                audioSource.Play();
            }
            else
            {
                audioSource.Stop();
            }
        }
    }


    private void FixedUpdate()
    {
        if (gameState != null && gameState.MusicUpdated)
        {
            if (gameState.MusicEffect)
            {
                audioSource.Play();
            } else
            {
                audioSource.Stop();
            }
            gameState.MusicUpdated = false;
        }
    }
}
