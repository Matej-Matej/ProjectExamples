using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Bullet : MonoBehaviour
{

    private float speed = -5f;
    private Rigidbody2D body;
    // Start is called before the first frame update
    void Start()
    {
        this.body = GetComponent<Rigidbody2D>();
        body.velocity = new Vector2(0f, speed);
    }

    void OnTriggerEnter2D ( Collider2D c)
    {
        if (c.name == "map")
        {
            Destroy(gameObject);
            return;
        }
        Destroy(gameObject,0.1f);
    }
}
