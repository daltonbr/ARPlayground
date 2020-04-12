using System;
using System.Collections;
using System.Collections.Generic;
using System.Net.Http.Headers;
using UnityEngine;
using Random = UnityEngine.Random;

public class Spawner : MonoBehaviour
{
    [SerializeField] private GameObject prefabToSpawn;
    [SerializeField] private WaitForSeconds waitTime = new WaitForSeconds(1f);
    
    private void Awake()
    {
        StartCoroutine(Spawn());
    }

    private IEnumerator Spawn()
    {
        while (true)
        {
            var randomOffset = Random.onUnitSphere * 0.1f;
            var gameObject = Instantiate(prefabToSpawn, transform.position + randomOffset, Random.rotation);
            Destroy(gameObject, 60f);
            yield return waitTime;
        }
    }
    
}
