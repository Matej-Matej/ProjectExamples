using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Pathfinding;

public class FlyingEnemy : MonoBehaviour
{
    public Transform target;
    private float speed = 800f;
    private float nextWaypointDistance = 3f;
    private Path path;
    private int currentWaypoint = 0;
    private bool reachedEndOfPath = false;
    private BoxCollider2D collider;
    [SerializeField] Vector3 scale;
    private Vector2 startingPosition;
    private int distance = 12;
    private bool is_dead = false;

    private float hurtPlayerTime = 2f;
    private float hurtPlayerTimer = 0;
    


    Seeker seeker;
    Rigidbody2D rb;


    // Start is called before the first frame update
    void Start()
    {
        seeker = GetComponent<Seeker>();
        rb = GetComponent<Rigidbody2D>();
        collider = GetComponent<BoxCollider2D>();
        startingPosition = rb.position;

        InvokeRepeating("UpdatePath", 0f, .5f);
        
    }

    void changePosition()
    {
        if (target.position.x > rb.position.x)
        {
            transform.localScale = scale;
        }
        else
        {
            transform.localScale = new Vector3(-scale.x, scale.y);
        }
    }

    void UpdatePath()
    {
        if (Vector2.Distance(target.position, rb.position) < distance && seeker.IsDone() && hurtPlayerTimer < 0)
            seeker.StartPath(rb.position, target.position, OnPathComplete);
        else
            seeker.StartPath(rb.position, startingPosition, OnPathComplete);
    }

    void OnPathComplete(Path p)
    {
        if (!p.error)
        {
            path = p;
            currentWaypoint = 0;
        }
    }
    // Update is called once per frame
    void FixedUpdate()
    {
        hurtPlayerTimer -= Time.deltaTime;
        if (!is_dead)
        {
            hurt();
            hurtPlayer();
            changePosition();
            if (path == null)
                return;

            if (currentWaypoint >= path.vectorPath.Count)
            {
                reachedEndOfPath = true;
                return;
            }
            else
            {
                reachedEndOfPath = false;
            }

            Vector2 direction = ((Vector2)path.vectorPath[currentWaypoint] - rb.position).normalized;
            Vector2 force = direction * speed * Time.deltaTime;

            rb.AddForce(force);

            float distance = Vector2.Distance(rb.position, path.vectorPath[currentWaypoint]);

            if (distance < nextWaypointDistance)
            {
                currentWaypoint++;
            }
        }
        
    }

    private void hurtPlayer()
    {
        if (collider.IsTouchingLayers(LayerMask.GetMask("Player")))
        {
            hurtPlayerTimer = hurtPlayerTime;
        }
    }

    private void hurt()
    {
        if (collider.IsTouchingLayers(LayerMask.GetMask("PlayerWeapon")))
        {
            GetComponent<Animator>().Play("fly_dead");
            is_dead = true;
        }
    }

    private void die()
    {
        Destroy(gameObject);
    }

}
