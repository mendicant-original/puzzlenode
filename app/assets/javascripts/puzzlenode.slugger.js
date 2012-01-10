// PuzzleNode.Slugger

PuzzleNode.setupNamespace("Slugger");

PuzzleNode.Slugger.watch = function(sourceField, destinationField){
  sourceField      = $('#' + sourceField);
  destinationField = $('#' + destinationField);

  sourceField.keyup(function(e){
    PuzzleNode.Slugger.generate(sourceField.val(), function(data){
      destinationField.val(data);
    })
  });
}

PuzzleNode.Slugger.generate = function(text, callback){
  $.get("/slugger", {'text': text}, function(data){
    callback(data);
  });
}
