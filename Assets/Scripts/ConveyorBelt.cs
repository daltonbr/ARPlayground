using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ConveyorBelt : MonoBehaviour
{
    [SerializeField] private float speed = .13f;
    [SerializeField] private Rigidbody _rigidbody;
    
    private void FixedUpdate()
    {
        _rigidbody.position -= transform.forward * (speed * Time.fixedDeltaTime);
        _rigidbody.MovePosition(_rigidbody.position + transform.forward * (speed * Time.fixedDeltaTime));
    }
    
    private void OnCollisionStay(Collision obj)
    {
        float beltVelocity = speed * Time.deltaTime;
        obj.gameObject.GetComponent<Rigidbody>().velocity = beltVelocity * transform.forward;
    }
}
