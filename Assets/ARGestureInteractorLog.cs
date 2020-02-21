using System;
using UnityEngine;
using UnityEngine.XR.Interaction.Toolkit.AR;

[RequireComponent(typeof(ARGestureInteractor))]
public class ARGestureInteractorLog : MonoBehaviour
{
    private ARGestureInteractor _arGestureInteractor;
    
    private void Start()
    {
        _arGestureInteractor = GetComponent<ARGestureInteractor>();

        _arGestureInteractor.DragGestureRecognizer.onGestureStarted += DragGestureRecognizerStarted;
        _arGestureInteractor.PinchGestureRecognizer.onGestureStarted += PinchGestureRecognizerStarted;
        _arGestureInteractor.TwoFingerDragGestureRecognizer.onGestureStarted += TwoFingerDragGestureRecognizerStarted;
        // _arGestureInteractor.TapGestureRecognizer;
        // _arGestureInteractor.TwistGestureRecognizer;
    }

    private static void DragGestureRecognizerStarted(Gesture<DragGesture> dragGesture)
    {
        Logger.Instance.LogInfo("DragGestureRecognizerStarted executed");
        
        dragGesture.onStart += (s) =>
        {
            Logger.Instance.LogInfo(" - dragGesture.onStart executed");
        };
        
        dragGesture.onUpdated += (s) =>
        {
            Logger.Instance.LogInfo(" - dragGesture.onUpdated executed");
        };
        
        dragGesture.onFinished += (s) =>
        {
            Logger.Instance.LogInfo(" - dragGesture.onFinished executed");
        };
    }
    
    private static void PinchGestureRecognizerStarted(Gesture<PinchGesture> pinchGesture)
    {
        Logger.Instance.LogInfo("PinchGestureRecognizerStarted executed");
        
        pinchGesture.onStart += (s) =>
        {
            Logger.Instance.LogInfo(" - pinchGesture.onStart executed");
        };
        
        pinchGesture.onUpdated += (s) =>
        {
            Logger.Instance.LogInfo(" - pinchGesture.onUpdated executed");
        };
        
        pinchGesture.onFinished += (s) =>
        {
            Logger.Instance.LogInfo(" - pinchGesture.onFinished executed");
        };
    }

    private static void TwoFingerDragGestureRecognizerStarted(Gesture<TwoFingerDragGesture> twoFingerDragGesture)
    {
        Logger.Instance.LogInfo("TwoFingerDragGestureRecognizerStarted executed");
        
        twoFingerDragGesture.onStart += (s) =>
        {
            Logger.Instance.LogInfo(" - twoFingerDragGesture.onStart executed");
        };
        
        twoFingerDragGesture.onUpdated += (s) =>
        {
            Logger.Instance.LogInfo(" - twoFingerDragGesture.onUpdated executed");
        };
        
        twoFingerDragGesture.onFinished += (s) =>
        {
            Logger.Instance.LogInfo(" - twoFingerDragGesture.onFinished executed");
        };
    }
}
