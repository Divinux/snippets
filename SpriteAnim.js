//vars for the whole sheet
var colCount: int =  4;
var rowCount: int =  4;

//vars for animation
var rowNumber: int =  0; //Zero Indexed
var colNumber: int =  0; //Zero Indexed
var totalCells: int =  4;
var fps: int = 10;
private var offset: Vector2;  //Maybe this should be a private var
private var index : int;
//Update
function Update ()
{
	SetSpriteAnimation(colCount,rowCount,rowNumber,colNumber,totalCells,fps);
}

//SetSpriteAnimation
function SetSpriteAnimation(colCount : int,rowCount : int,rowNumber : int,colNumber : int,totalCells : int,fps : int)
{
	
	// Calculate index
	/*index = Time.time * fps;
	print(Time.time);
	// Repeat when exhausting all cells
	index = index % totalCells;*/
	
	index++;
	
	// Size of every cell
	var size = Vector2 (1.0 / colCount, 1.0 / rowCount);
	
	// split into horizontal and vertical index
	var uIndex = index % colCount;
	var vIndex = index / colCount;
	
	// build offset
	// v coordinate is the bottom of the image in opengl so we need to invert.
	offset = Vector2 ((uIndex+colNumber) * size.x, (1.0 - size.y) - (vIndex+rowNumber) * size.y);
	
	renderer.material.SetTextureOffset ("_MainTex", offset);
	renderer.material.SetTextureScale  ("_MainTex", size);
	
	if(index >= 120)
	{
		Destroy(gameObject);
	}
}