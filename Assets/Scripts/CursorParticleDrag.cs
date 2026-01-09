using UnityEngine;

public class CursorParticleDrag : MonoBehaviour {
    // Update is called once per frame
    private void Update() {
        // Get the mouse position in screen space
        Vector3 mousePosition = Input.mousePosition;

        // Ensure there is a main camera
        if (Camera.main == null) {
            Debug.LogWarning("No main camera found.");
            enabled = false;
            return;
        }

        Camera camera = Camera.main;

        // Set the z-distance to the particle system's current distance from the camera
        mousePosition.z = Mathf.Abs(camera.transform.position.z - transform.position.z);

        // Convert the mouse position to world space
        Vector3 worldPosition = camera.ScreenToWorldPoint(mousePosition);

        // Update the particle effect's position
        transform.position = worldPosition;
    }
}
