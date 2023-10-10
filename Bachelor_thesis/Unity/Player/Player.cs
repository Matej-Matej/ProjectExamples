using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Player : MonoBehaviour
{
    const float SPEED = 12f;
    const float JUMP_SPEED = 21f;
    const int MAX_JUMP = 2;
    //const int BOOST_MULTIPLIER = 2;

    private int jumpCount = 0;

    private Rigidbody2D body;
    private Animator animator;
    private CapsuleCollider2D bodyCollider;
    private SpriteRenderer renderer;
    private AudioSource audio;
    private GameState state;
    [SerializeField] private ParticleSystem particles;
    [SerializeField] private Transform floorCheck;
    [SerializeField] private LayerMask defineFloor;
    [SerializeField] private BoxCollider2D weaponAreaRight;
    [SerializeField] private BoxCollider2D weaponAreaLeft;
    [SerializeField] private AudioClip jumpAudio;
    [SerializeField] private AudioClip hurtAudio;

    private float invulnerabilityTime = 1.5f;
    private float invulnerabilityTimer = 0;

    private bool is_attacking;
    private bool is_jumping;
    private bool is_running;
    // Start is called before the first frame update
    void Start()
    {
        jumpCount = 0;
        body = GetComponent<Rigidbody2D>();
        animator = GetComponent<Animator>();
        bodyCollider = GetComponent<CapsuleCollider2D>();
        renderer = GetComponent<SpriteRenderer>();
        audio = GetComponent<AudioSource>();
        state = FindObjectsOfType<GameState>()[0];
        renderer.color = new Color(1, 0, 0);
    }

    // Update is called once per frame
    void Update()
    {
        if (!animator.GetBool("is_dead"))
        {
            invulnerabilityTimer -= Time.deltaTime;
            if (invulnerabilityTimer > 0)
            {
                if (invulnerabilityTimer < 1) renderer.material.color = Color.white;
                if (invulnerabilityTimer < 0.5) renderer.material.color = Color.red;

            } else
            {
                if (renderer.material.color != Color.white) renderer.material.color = Color.white;
            }
            animate();
            jump();
            hurt();
            move();
            attack();
        }
        else
        {
            animator.Play("Player_dead");
        }
            

    }

    private void animate()
    {
        if (is_attacking)
            animator.Play("Player_attack");
        else if (is_jumping)
            animator.Play("Player_jump");
        else if (is_running)
            animator.Play("Player_run");
        else
            animator.Play("Player_idle");
    }

    void move()
    {
        if (!is_attacking)
        {
            float controlThrow = Input.GetAxis("ui_horizontal");
            Vector2 playerVelocity = new Vector2(controlThrow * SPEED, body.velocity.y);
            body.velocity = playerVelocity;
            is_running = true;
        }
        else
            body.velocity = new Vector2(0, body.velocity.y);
        
        if (body.velocity.x != 0) // kontroluje  sa preto, aby ostal smerom tak ako bol 
        {
            renderer.flipX = body.velocity.x < 0;
        }
        if (body.velocity.x == 0)
            is_running = false;
    }

    void jump()
    {
        if (Physics2D.OverlapCircle(floorCheck.position, 0.1f, defineFloor))
        {
            is_jumping = false;
            jumpCount = 0;
        }

        if (jumpCount < MAX_JUMP && Input.GetButtonDown("ui_up"))
        {
            if (this.state.SoundEffect) audio.PlayOneShot(jumpAudio);
            is_jumping = true;
            jumpCount++;
            Vector2 jumpVelocityToAdd = new Vector2(0f, JUMP_SPEED);
            body.velocity = jumpVelocityToAdd;
        }
    }

    void attack()
    {
        if (Input.GetButton("ui_attack"))
        {
            is_attacking = true;
            enableWeaponArea();
        }
        else
        {
            weaponAreaRight.gameObject.SetActive(false);
            weaponAreaLeft.gameObject.SetActive(false);
            is_attacking = false;

        }
    }

    private void enableWeaponArea()
    {
        weaponAreaLeft.gameObject.SetActive(renderer.flipX);
        weaponAreaRight.gameObject.SetActive(!renderer.flipX);
    }

    public void hurt()
    {
        if (invulnerabilityTimer < 0 && bodyCollider.IsTouchingLayers(LayerMask.GetMask("Enemy")))
        {
            invulnerabilityTimer = invulnerabilityTime;
            renderer.material.color = Color.red;
            if (this.state.SoundEffect) audio.PlayOneShot(hurtAudio);
            if (this.state.looseLife())
            {
                renderer.material.color = Color.white;
                animator.SetBool("is_dead", true);
            }
        }
    }

    public void heal()
    {
        particles.Emit(20);
    }

    public void die()
    {
        SceneManager.LoadScene("GameOverScreen");
    }
}
