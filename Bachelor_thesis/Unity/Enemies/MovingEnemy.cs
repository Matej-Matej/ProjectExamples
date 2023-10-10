using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MovingEnemy : MonoBehaviour
{

    private Rigidbody2D body;
    [SerializeField] private Transform floorCheck;
    [SerializeField] private Transform wallCheck;
    [SerializeField] private LayerMask defineFloor;
    [SerializeField] private Vector2 scale;
    private BoxCollider2D collider;
    const float speed = 2f;
    private int lifes = 2;
    private bool is_dead = false;
    private bool movingLeft = true;
    private float invulnerabilityTime = .5f;
    private float invulnerabilityTimer = 0;
    // Start is called before the first frame update
    void Start()
    {
        body = GetComponent<Rigidbody2D>();
        collider = GetComponent<BoxCollider2D>();
    }

    void Update()
    {
        if (!is_dead)
        {
            invulnerabilityTimer -= Time.deltaTime;
            move();
            hurt();
        }
    }

    void move()
    {
        if (!Physics2D.OverlapCircle(floorCheck.position, 0.1f, defineFloor) || Physics2D.OverlapCircle(wallCheck.position, 0.1f, defineFloor)) // okolo pozicie sa vytvori gulicka ktora skuma collision
            movingLeft = !movingLeft;

        if (movingLeft)
        {
            transform.localScale = new Vector3(scale.x, scale.y);
            body.velocity = new Vector2(-speed,0f);
        }
        else
        {
            transform.localScale = new Vector3(-scale.x, scale.y);
            body.velocity = new Vector2(speed,0f);
        }
    }

    private void hurt()
    {
        if (invulnerabilityTimer < 0 && collider.IsTouchingLayers(LayerMask.GetMask("PlayerWeapon")))
        {
            invulnerabilityTimer = invulnerabilityTime;
            GetComponent<Animator>().Play("movingEnemy_hit");
            looseLife();
        }
    }

    private void looseLife()
    {
        lifes--;
        if (lifes <= 0)
        {
            dead();
        }
    }

    private void dead()
    {
        is_dead = true;
        GetComponent<Animator>().Play("movingEnemy_dead");
        body.velocity = new Vector2(0f, 0f);
    }

    private void destroyEnemy()
    {
        Destroy(gameObject);
    }
}
