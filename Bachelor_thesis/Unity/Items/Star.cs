using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Star : MonoBehaviour
{
    private Animator animator;
    private GameState state;

    void Start()
    {
        this.state = FindObjectsOfType<GameState>()[0];
        this.animator = GetComponent<Animator>();
    }

    private void OnTriggerEnter2D(Collider2D c)
    {
        GameObject.Find("LevelState").GetComponent<LevelState>().Star = true;
        this.state.IsUpdated = true;
        if (this.state.SoundEffect) GetComponent<AudioSource>().Play();
        animator.SetBool("is_dead", true);
    }

    public void die()
    {
        Destroy(gameObject);
    }
}
