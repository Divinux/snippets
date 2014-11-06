using UnityEditor;





class ExtraSettings


{


	[MenuItem("Extra Settings/Enable MT Rendering")]


	static void EnableMTRendering()


	{


		UnityEditor.PlayerSettings.MTRendering = true;


	}





	[MenuItem("Extra Settings/Disable MT Rendering")]


	static void DisableMTRendering()


	{


		UnityEditor.PlayerSettings.MTRendering = false;


	}


}