using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class WorldComplete : MonoBehaviour
{
    [SerializeField] string nextLevel;
    private Animator animator;
    private LevelState state;
    private GameState gameState;

    void Start()
    {
        state = GameObject.Find("LevelState").GetComponent<LevelState>();
        animator = GetComponent<Animator>();
        gameState = FindObjectsOfType<GameState>()[0];
    }

    void Update()
    {
        if (Input.GetButtonDown("ui_skip"))
        {
            gameState.Lifes = GameState.MAX_LIFE;
            SceneManager.LoadScene(nextLevel);
        }

        if (state.Star)
        {
            animator.SetBool("have_star", true);
            enabled = false;
        }
    }

    void OnTriggerEnter2D(Collider2D c)
    {
        if (animator.GetBool("have_star") && c.gameObject.name == "Player")
        {
            gameState.Lifes = GameState.MAX_LIFE;
            SceneManager.LoadScene(nextLevel);
        }  
    }
}
