using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum SelectedCoin { coinBronze, coinSilver, coinGold };


public class Coin : MonoBehaviour
{
    const int GOLD_SCORE = 10;
    const int SILVER_SCORE = 5;
    const int BRONZE_SCORE = 1;

    [SerializeField] SelectedCoin selectedCoin;
    private Sprite coinSprite;
    private int score;
    private SpriteRenderer renderer;
    private Animator animator;
    private GameState state;

    // Start is called before the first frame update
    void Start()
    {
        this.state = FindObjectsOfType<GameState>()[0];
        animator = GetComponent<Animator>();
        renderer = GetComponent<SpriteRenderer>();
        if (selectedCoin == SelectedCoin.coinBronze)
        {
            coinSprite = Resources.Load<Sprite>("coinBronze");
            score = BRONZE_SCORE;
        }
        else if (selectedCoin == SelectedCoin.coinSilver)
        {
            coinSprite = Resources.Load<Sprite>("coinSilver");
            score = SILVER_SCORE;
        }
        else
        {
            coinSprite = Resources.Load<Sprite>("coinGold");
            score = GOLD_SCORE;
        }
        renderer.sprite = coinSprite;
    }

    private void OnTriggerEnter2D(Collider2D c)
    {
        if (!animator.GetBool("is_dead"))
        {
            if (this.state.SoundEffect) GetComponent<AudioSource>().Play();
            this.state.addScore(score);
            animator.SetBool("is_dead", true);
        }
        
    }

    private void die()
    {
        Destroy(gameObject);
    }
}
