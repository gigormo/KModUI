using System.IO;
using UnityEditor;

#if UNITY_EDITOR

public class CreateAssetBundles {

    [MenuItem("Assets/Build AssetBundles")]
    private static void BuildAllAssetBundles() {
        string assetBundleDirectory = "Assets/AssetBundles";
        //string destinationPath = "E:/Games/Stickman Strikes/BepInEx/plugins/KMod/kmodbundle";

        //Debug.Log($"GetAccessControl: {destinationPath}");

        // 1. Ensure local folder exists for the build process
        if (!Directory.Exists(assetBundleDirectory)) _ = Directory.CreateDirectory(assetBundleDirectory);

        _ = BuildPipeline.BuildAssetBundles(assetBundleDirectory, BuildAssetBundleOptions.None, BuildTarget.StandaloneWindows64);

        //if (File.Exists($"{assetBundleDirectory}/kmodbundle")) {
        //    if (File.Exists(destinationPath)) File.Delete(destinationPath);
        //    File.Move($"{assetBundleDirectory}/kmodbundle", destinationPath);
        //    Debug.Log("Bundle moved successfully!");
        //}
    }
}

#endif