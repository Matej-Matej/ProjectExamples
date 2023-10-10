using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class FinalBoss : MonoBehaviour
{

    private BoxCollider2D bodyCollider;
    private GameState state;
    private bool isImmortal = false;
    private int lifes = 3;
    [SerializeField] private Transform[] paths;
    [SerializeField] private GameObject bullet;
    [SerializeField] private Transform firePosition;
    private float speed = 10f;
    private float maxTime = 0.7f;
    private float shootingTimer;
    private int pathIndex;
    private int step = 0;
    private float waitTime = 5f;
    private float waitTimer;
    private bool is_dead = false;


    // Start is called before the first frame update
    void Start()
    {
        this.state = FindObjectsOfType<GameState>()[0];
        this.state.BossLevel = true;
        this.state.IsUpdated = true;
        waitTimer = waitTime;
        pathIndex = paths.Length - 1;
        inicializeTimer();
        transform.position = paths[pathIndex].transform.position;
        this.bodyCollider = GetComponent<BoxCollider2D>();
    }

    // Update is called once per frame
    void Update()
    {
        waitTimer -= Time.deltaTime;
        if (isImmortal)
        {
            shootingTimer -= Time.deltaTime;
            if (shootingTimer <= 0)
            {
                shoot();
                inicializeTimer();
            }
        }
        else
        {
            hurt();
        }
        if (!is_dead)
            move();
    }

    private void move()
    {
        if (step == 0)
        {
            // je v pathIndex2
            pathIndex = 1;
        }
        else if (step == 1)
        {
            isImmortal = true;
            pathIndex = 0;
        }
        else if (step == 2)
        {
            pathIndex = 1;
        }
        else if (step == 3)
        {
            pathIndex = 0;
        }
        else if (step == 4)
        {
            pathIndex = 1;
        }
        else if (step == 5)
        {
            isImmortal = false;

            pathIndex = 2;
        }
        if (waitTimer < 0)
        {
            transform.position = Vector2.MoveTowards(transform.position, paths[pathIndex].transform.position, speed * Time.deltaTime);

            if (transform.position == paths[pathIndex].transform.position)
            {
                step++;
                if (step == 6)
                {
                    waitTimer = waitTime;
                    step = 0;
                }
            }
        }
            
    }

    public void hurt()
    {
        if (!isImmortal && bodyCollider.IsTouchingLayers(LayerMask.GetMask("PlayerWeapon")))
        {
            looseLife();
            isImmortal = true;
            waitTimer = -5;
        }
    }

    private void looseLife()
    {
        lifes--;
        GetComponent<Animator>().SetInteger("lifes", lifes);
        if (lifes == 0)
        {
            is_dead = true;
        }
    }

    public void die()
    {
        Destroy(gameObject);
        SceneManager.LoadScene("GameOverScreen");
    }

    private void shoot()
    {
        if (!is_dead)
        {
            Instantiate(bullet, firePosition.position, firePosition.rotation);
            if (this.state.SoundEffect) GetComponent<AudioSource>().Play();
        }

    }

    private void inicializeTimer()
    {
        shootingTimer = Random.Range(0f, maxTime);
    }
}
