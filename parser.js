function ParseObjs(lns:String):Mesh[]{

                var usesPositiveModel:boolean=true;

                var objectAmount:int;

                var ln:String[]=lns.Replace("\n",System.Environment.NewLine).Split(System.Environment.NewLine[0]);

                for(var line in ln){

                        if(line.length>1){

                                if(line[0]=="f"&&line[1]==" "){

                                        for(var shoe in line.Split(" "[0])[1].Split("/"[0])){

                                                if(float.Parse(shoe)<0)

                                                        usesPositiveModel=false;

                                        }

                                }

                                else if(line[0]=="o"&&line[1]==" "){

                                        objectAmount++;

                                }

                                else if(line[0]=="g"&&line[1]==" ")

                                        objectAmount++;

                        }

                }

                

                if(objectAmount==0)

                        objectAmount=1;

 

        if(!usesPositiveModel)

                return;

 

        var i:int=0;

        var j:int=0;

        

        

        var vertexArray:Array=new Array();

        var uvArray:Array=new Array();

        var normalsArray:Array=new Array();

        

        var mvertexArray:Array=new Array();

        var muvArray:Array=new Array();

        var mnormalsArray:Array=new Array();

        

        var mtriangleArray:Array=new Array();

        

        var currentMesh:int=-1;

        

        var splitSpace:String[];

        

        var finMeshes:Mesh[]=new Mesh[objectAmount];

        

        for(var dumm in finMeshes){

                dumm=new Mesh();

                dumm.Clear();

        }

        

        var dummyInt:int;

        

        for(i=0;i<ln.length;i++){

                ln[i]=ln[i].Replace("     "," ");

                ln[i]=ln[i].Replace("    "," ");

                ln[i]=ln[i].Replace("   "," ");

                ln[i]=ln[i].Replace("  "," ");

                splitSpace=ln[i].Split(" "[0]);

                if(ln[i].length>2){

                        if(ln[i][0]=="v"&&ln[i][1]==" "){

                                vertexArray.Push(Vector3(float.Parse(splitSpace[1])*0.1,float.Parse(splitSpace[2])*0.1,float.Parse(splitSpace[3])*0.1));

                        }

                        else if(ln[i][0]=="v"&&ln[i][1]=="t"&&ln[i][2]==" "){

                                uvArray.Push(Vector2(float.Parse(splitSpace[1]),float.Parse(splitSpace[2])));

                        }

                        else if(ln[i][0]=="v"&&ln[i][1]=="n"&&ln[i][2]==" "){

                                normalsArray.Push(Vector3(float.Parse(splitSpace[1])*0.1,float.Parse(splitSpace[2])*0.1,float.Parse(splitSpace[3])*0.1));

                        }

                        else if(ln[i][0]=="f"&&ln[i][1]==" "){

                         //v/uv/norm

                                var vertLength:int=mvertexArray.length;

                                for(j=1;j<splitSpace.length;j++){

                                        if(splitSpace[j].length>0){

                                                if(int.TryParse(splitSpace[j][0]+"",dummyInt)){

                                                        var splitFace:String[]=splitSpace[j].Split("/"[0]);

                                                        if(splitFace.length>0){

                                                                Debug.Log("vertex array: "+vertexArray.length);

                                                                Debug.Log("splitface: "+splitFace[0]);

                                                                mvertexArray.Push(vertexArray[int.Parse(splitFace[0])-1]);

                                                                if(splitFace.length>1)

                                                                        if(splitFace[1]!="")

                                                                                muvArray.Push(uvArray[int.Parse(splitFace[1])-1]);

                                                                if(splitFace.length>2)

                                                                        if(splitFace[2]!="")

                                                                                mnormalsArray.Push(normalsArray[int.Parse(splitFace[2])-1]);

                                                

                                                        }

                                                }

                                        }

                                }

                                

                                for(j=1;j<mvertexArray.length-1-vertLength;j++){

                                //      Debug.Log("------------------");

                                        mtriangleArray.Push(vertLength);

                                        //Debug.Log("Pushing "+vertLength);

                                        mtriangleArray.Push(vertLength+j);

                                        //Debug.Log("Pushing "+(vertLength+j).ToString());

                                        mtriangleArray.Push(vertLength+j+1);

                                        //Debug.Log("Pushing "+(vertLength+j+1).ToString());

                                        //Debug.Log("------------------");

                                }

                                

                        }

                        else if(ln[i][0]=="g"&&ln[i][1]==" "){

                                if(currentMesh>=0){

                                        finMeshes[currentMesh]=new Mesh();

                                        finMeshes[currentMesh].Clear();

                                        

                                        finMeshes[currentMesh].vertices=new Vector3[mvertexArray.length];

                                        finMeshes[currentMesh].normals=new Vector3[mnormalsArray.length];

                                        finMeshes[currentMesh].uv=new Vector2[muvArray.length];

                                        finMeshes[currentMesh].triangles=new int[mtriangleArray.length];

                                        

                                        finMeshes[currentMesh].vertices=mvertexArray.ToBuiltin(Vector3) as Vector3[];

                                        finMeshes[currentMesh].uv=muvArray.ToBuiltin(Vector2) as Vector2[];

                                        finMeshes[currentMesh].normals=mnormalsArray.ToBuiltin(Vector3) as Vector3[];

                                        finMeshes[currentMesh].triangles=mtriangleArray.ToBuiltin(int) as int[];

                                        finMeshes[currentMesh].RecalculateBounds();

                                }

                                currentMesh++;

                                mvertexArray=new Array();

                                muvArray=new Array();

                                mnormalsArray=new Array();

                                mtriangleArray=new Array();

                        }

                        else if(ln[i][0]=="o"&&ln[i][1]==" "){

                                if(currentMesh>=0){

                                        finMeshes[currentMesh]=new Mesh();

                                        finMeshes[currentMesh].Clear();

                                        

                                        finMeshes[currentMesh].vertices=new Vector3[mvertexArray.length];

                                        finMeshes[currentMesh].normals=new Vector3[mnormalsArray.length];

                                        finMeshes[currentMesh].uv=new Vector2[muvArray.length];

                                        finMeshes[currentMesh].triangles=new int[mtriangleArray.length];

                                        

                                        finMeshes[currentMesh].vertices=mvertexArray.ToBuiltin(Vector3) as Vector3[];

                                        finMeshes[currentMesh].uv=muvArray.ToBuiltin(Vector2) as Vector2[];

                                        finMeshes[currentMesh].normals=mnormalsArray.ToBuiltin(Vector3) as Vector3[];

                                        finMeshes[currentMesh].triangles=mtriangleArray.ToBuiltin(int) as int[];

                                        finMeshes[currentMesh].RecalculateBounds();

                                }

                                currentMesh++;

                                //vertexArray=new Array();

                                //uvArray=new Array();

                                //normalsArray=new Array();

                                mvertexArray=new Array();

                                muvArray=new Array();

                                mnormalsArray=new Array();

                                mtriangleArray=new Array();

                        }

                }

        }

        finMeshes[currentMesh]=new Mesh();

        finMeshes[currentMesh].Clear();

        

        finMeshes[currentMesh].vertices=new Vector3[mvertexArray.length];

        finMeshes[currentMesh].normals=new Vector3[mnormalsArray.length];

        finMeshes[currentMesh].triangles=new int[mtriangleArray.length];

        

        finMeshes[currentMesh].vertices=mvertexArray.ToBuiltin(Vector3) as Vector3[];

        finMeshes[currentMesh].uv=muvArray.ToBuiltin(Vector2) as Vector2[];

        finMeshes[currentMesh].normals=mnormalsArray.ToBuiltin(Vector3) as Vector3[];

        finMeshes[currentMesh].triangles=mtriangleArray.ToBuiltin(int) as int[];

        finMeshes[currentMesh].RecalculateBounds();

        

        return finMeshes;

        

}