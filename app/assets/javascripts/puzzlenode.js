var PuzzleNode = PuzzleNode ? PuzzleNode : new Object();

PuzzleNode.setupNamespace = function(namespace){
  if(PuzzleNode[namespace] == undefined)
    PuzzleNode[namespace] = {}
}
