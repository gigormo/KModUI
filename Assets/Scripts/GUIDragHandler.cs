using UnityEngine;
using UnityEngine.EventSystems;

public class GUIDragHandler : MonoBehaviour, IDragHandler, IBeginDragHandler {
    private Vector2 lastMousePosition;

    // This runs when you first click the panel
    public void OnBeginDrag(PointerEventData eventData) {
        lastMousePosition = eventData.position;
    }

    // This runs every frame while you are dragging
    public void OnDrag(PointerEventData eventData) {
        Vector2 currentMousePosition = eventData.position;
        Vector2 diff = currentMousePosition - lastMousePosition;

        // Move the panel's RectTransform
        RectTransform rect = GetComponent<RectTransform>();
        rect.anchoredPosition += diff;

        lastMousePosition = currentMousePosition;
    }
}
