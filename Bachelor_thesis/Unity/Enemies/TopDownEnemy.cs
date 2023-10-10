using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TopDownEnemy : MonoBehaviour
{

    const float speed = 2f;
    private bool movingUp = true;
    [SerializeField] private Vector2 scale;

    private Rigidbody2D body;

    [SerializeField] private Transform wallCheck;
    [SerializeField] private LayerMask defineWall;

    // Start is called before the first frame update
    void Start()
    {
        body = GetComponent<Rigidbody2D>();
    }

    // Update is called once per frame
    void Update()
    {
        move();
    }

    void move()
    {

        if (Physics2D.OverlapCircle(wallCheck.position, 0.1f, defineWall)) // okolo pozicie sa vytvori gulicka ktora skuma collision
            movingUp = !movingUp;
 

        if (movingUp)
        {
            transform.localScale = new Vector3(scale.x, scale.y);
            body.velocity = new Vector2(0f, speed);
        }
        else
        {
            transform.localScale = new Vector3(scale.x, -scale.y);
            body.velocity = new Vector2(0f, -speed);
        }
    }
}
