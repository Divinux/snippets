/*01:49 - Professor Slack: And just put the shader you want to shaderToUse.
01:49 - Professor Slack: Or a material you want.
01:49 - Professor Slack: to materialToUse.
01:49 - Professor Slack: Add this to a camera, camera will now use shader for post processing effect.
01:49 - Professor Slack: Or material.
*/
var materialToUse:Material;
var shaderToUse:Shader;
function Awake(){
if(materialToUse==null){
materialToUse=new Material(shaderToUse);
materialToUse.hideFlags = HideFlags.DontSave;
}
}
function OnRenderImage (source : RenderTexture, destination : RenderTexture) {
Graphics.Blit (source, destination, materialToUse);
}
