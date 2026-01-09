using UnityEngine;
using UnityEngine.UI;

public class SetIsPressed : MonoBehaviour {
    [SerializeField] private Material pressedMaterial;
    [SerializeField] private float resetDelay = 0.3f; // Time in seconds before resetting the material

    private Material targetMaterial;
    private Button button;
    private float timer = 0.0f; // Timer to track countdown

    private void Start() {
        targetMaterial = GetComponent<Image>().material;
        button = GetComponent<Button>();
        if (button != null) {
            button.onClick.AddListener(ToggleIsPressed);
        }
    }

    private void Update() {
        // Countdown the timer if it's active
        if (timer > 0) {
            timer -= Time.deltaTime; // Decrease timer by the time elapsed since the last frame
            if (timer <= 0) {
                ResetMaterial(); // Trigger the reset when the timer reaches zero
            }
        }
    }

    public void ToggleIsPressed() {

        GetComponent<Image>().material = pressedMaterial;

        // Start the timer for resetting the material
        timer = resetDelay;
    }

    private void ResetMaterial() {
        // Reset the material to the target material
        GetComponent<Image>().material = targetMaterial;
        Debug.Log("Material reset to targetMaterial.");
    }
}