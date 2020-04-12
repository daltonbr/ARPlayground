using UnityEngine;

public class Lamp : MonoBehaviour
{
    [SerializeField] private Animator animator;
    private static readonly int Jump = Animator.StringToHash("Jump");

    public void TriggerJump()
    {
        animator.SetTrigger(Jump);
    }
}
