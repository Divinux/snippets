using UnityEngine;

[System.Serializable]
public class NodeIndex {
	public int i = -1, j = -1; // [i - ROW Index] [j - COLUMN Index]
}

[System.Serializable]
public class Node {
	public Node parent = null; // NODE's Parent
	
	public int F = 0; // F = G + H
	public int G = 0; // G - cost from START to this NODE
	public int H = 0; // H - cost from this NODE to END (heuristic Manhattan method)
	
	public NodeIndex nodeIndex = new NodeIndex(); // Node Index = (i,j)
}