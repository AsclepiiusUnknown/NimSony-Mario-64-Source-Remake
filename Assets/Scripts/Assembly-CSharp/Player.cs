using UnityEngine;

public class Player : MonoBehaviour
{
	public Transform cam;
	public Animator anim;
	public CharacterController mover;
	public ParticleSystem runCloud;
	public ParticleSystem runSplash;
	public ParticleSystem skidCloud;
	public ParticleSystem jumpCloud;
	public ParticleSystem landCloud;
	public ParticleSystem poundCloud;
	public ParticleSystem bubbleFx;
	public AudioSource slideSfx;
	public AudioSource sfx;
	public AudioClip[] jump1Fx;
	public AudioClip[] jump2Fx;
	public AudioClip[] jump3Fx;
	public AudioClip[] jumpLongFx;
	public AudioClip[] jumpDiveFx;
	public AudioClip[] kickFx;
	public AudioClip[] treeFx;
	public AudioClip[] landStepFx;
	public bool rootCollision;
	public Vector3 relV;
	public Vector3 velocity;
	public Vector3 velXZ;
	public bool grounded;
	public LayerMask groundLayers;
	public Door door;
	public Tree tree;
	public Vector3 groundNormal;
	public int groundType;
	public LayerMask waterLayers;
	public float submergence;
	public bool submerged;
}
