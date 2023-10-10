using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class JumpPad : MonoBehaviour
{
    const float JUMP_BOOST = 24f;
    [SerializeField] Rigidbody2D body;

    private Animator animator;

    void Start()
    {
        animator = GetComponent<Animator>();
    }

    private void OnTriggerEnter2D(Collider2D c)
    {
        if (c.name == "Player")
        {
            body.velocity = new Vector2(0f, JUMP_BOOST);
            animator.SetBool("boosting", true);
        }
       
    }

    private void stopAnimation()
    {
        animator.SetBool("boosting", false);
    }
}
