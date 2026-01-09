using UnityEditor;
using UnityEngine;

#if UNITY_EDITOR
[CustomEditor(typeof(Material))]
public class UIShaderTypeToggleInspector : MaterialEditor {
    public override void OnInspectorGUI() {
        //    // Draw the default inspector.
        base.OnInspectorGUI();

        //    // If we are not visible, return.
        //    if (!isVisible)
        //        return;

        //    // Get the current material
        //    Material targetMat = target as Material;
        //    if (targetMat == null) return;

        //    // Get the current keywords from the material
        //    string[] keyWords = targetMat.shaderKeywords;

        //    // Retrieve the current state of the shader keywords
        //    bool isFillBar = keyWords.Contains("ISFILLBAR");
        //    bool isMainUI = keyWords.Contains("ISMAINUI");
        //    bool isButton = keyWords.Contains("ISBUTTON");

        //    // Display toggles for the shader types
        //    EditorGUI.BeginChangeCheck();
        //    isFillBar = EditorGUILayout.Toggle("Is Fill Bar?", isFillBar);
        //    isMainUI = EditorGUILayout.Toggle("Is Main UI?", isMainUI);
        //    isButton = EditorGUILayout.Toggle("Is Button?", isButton);

        //    // If any toggle state has changed, update the shader keywords
        //    if (EditorGUI.EndChangeCheck()) {
        //        List<string> keywords = new();

        //        if (isFillBar) keywords.Add("ISFILLBAR");
        //        if (isMainUI) keywords.Add("ISMAINUI");
        //        if (isButton) keywords.Add("ISBUTTON");

        //        // Apply the updated keywords to the material
        //        targetMat.shaderKeywords = keywords.ToArray();
        //        EditorUtility.SetDirty(targetMat);
        //    }
        //}
    }
}
#endif