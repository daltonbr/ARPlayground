using System;
using TMPro;
using UnityEngine;
using System.Linq;
using DaltonLima.Core;

public class Logger : Singleton<Logger>
{
    [SerializeField] private TextMeshProUGUI debugAreaText;
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
        ClearLines();
        debugAreaText.text += $"{DateTime.Now:yyyy-dd-M-HH-mm-ss}<color=\"white\">(message)</color>\n";
    }

    public void LogWarning()
    {
        ClearLines();
        debugAreaText.text += $"{DateTime.Now:yyyy-dd-M-HH-mm-ss}<color=\"yellow\">(message)</color>\n";
    }
    
    public void LogError()
    {
        ClearLines();
        debugAreaText.text += $"{DateTime.Now:yyyy-dd-M-HH-mm-ss}<color=\"red\">(message)</color>\n";
    }

    private void ClearLines()
    {
        if (debugAreaText.text.Split('\n').Count() >= maxLines)
        {
            debugAreaText.text = string.Empty;
        }
    }
}
