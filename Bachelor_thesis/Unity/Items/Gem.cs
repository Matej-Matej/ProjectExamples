using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum SelectedGem { gemBlue, gemGreen, gemRed };

public class Gem : MonoBehaviour
{

    private LevelState levelState;
    [SerializeField] SelectedGem selectedGem;
    private Sprite gemSprite;
    private SpriteRenderer renderer;
    private Animator animator;
    private GameState state;

    // Start is called before the first frame update
    void Start()
    {
        this.state = FindObjectsOfType<GameState>()[0];
        this.levelState = GameObject.Find("LevelState").GetComponent<LevelState>();
        this.animator = GetComponent<Animator>();
        this.renderer = GetComponent<SpriteRenderer>();
        if (selectedGem == SelectedGem.gemBlue)
        {
            gemSprite = Resources.Load<Sprite>("hudJewel_blue");
        }
        else if (selectedGem == SelectedGem.gemGreen)
        {
            gemSprite = Resources.Load<Sprite>("hudJewel_green");
        }
        else
        {
            gemSprite = Resources.Load<Sprite>("hudJewel_red");
        }
        renderer.sprite = gemSprite;
    }

    private void OnTriggerEnter2D(Collider2D c)
    {
        if (selectedGem == SelectedGem.gemBlue)
        {
            this.levelState.BlueGem = true;
        }
        else if (selectedGem == SelectedGem.gemGreen)
        {
            this.levelState.GreenGem = true;
        }
        else
        {
            this.levelState.RedGem = true;
        }
        animator.SetBool("is_dead", true);
        if (this.state.SoundEffect) GetComponent<AudioSource>().Play();
        this.state.IsUpdated = true;

    }

    public void die()
    {
        Destroy(gameObject);
    }
}
