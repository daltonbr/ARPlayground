using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using System.Linq;
using UnityEngine.PlayerLoop;

//TODO: implement Singleton
public class Logger : MonoBehaviour
{
   [SerializeField] private TextMeshPro debugAreaText;
   [SerializeField] private bool enableDebug;
   [SerializeField] private int maxLines;

   private void OnEnable()
   {
      debugAreaText.enabled = enableDebug;
      enabled = enableDebug;
   }

   private void OnDisable()
   {
      throw new NotImplementedException();
   }

   public void LogInfo(string message)
   {
      //ClearLines();
      //debugAreaText.text += $"(DateTime.Now.ToString("HH-mm-ss"))color=\"white\">(message)</color>\n";
   }

   public void LogError()
   {
      
   }

}
