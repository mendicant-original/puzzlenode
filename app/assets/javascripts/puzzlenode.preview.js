PuzzleNode.setupNamespace("Preview");

PuzzleNode.Preview.init = function(){
  $("textarea[data-preview=true]").each(function(index) {
		PuzzleNode.Preview.buildPreviewTab($(this));
	});

	// override tab clicks
	$('ul.tabs li:not(.label) a').live('click', function(e) {
		var tabs = $(this).parents('ul').find('li');
		var tab_contents = $(this).parents('ul').next('.tab_container').find('.tab_content');

		tabs.removeClass("active");
		$(this).parent().addClass("active");
		tab_contents.hide();

		// convert markdown for preview
		if($(this).attr("href") == "#preview"){
      PuzzleNode.Preview.convertMarkdown(tab_contents);
    }

		// show active tab contents
		var activeTab = tab_contents.filter($(this).attr("href"));
		$(activeTab).show();

		e.preventDefault();
	});

	// override links in preview
	$('#preview a').live('click', function(e){
    window.open(e.target.href);
    e.preventDefault();
	});
}

PuzzleNode.Preview.buildPreviewTab = function(textarea){
  // insert tabs
	textarea.before(' \
		<ul class="tabs"> \
			<li><a href="#edit">Edit</a></li> \
			<li><a href="#preview">Preview</a></li> \
		</ul>');

	// wrap textarea
	textarea.wrap('<div class="tab_content" id="edit" />');

	// tab_container wrapper
	textarea.parent().wrap('<div class="tab_container" />');

	// create #preview as a sibling as #edit
	textarea.parent().after('<div id="preview" class="tab_content preview">Preview</div>');

	// activate tab links
	PuzzleNode.Preview.enableTabs(textarea);
}

PuzzleNode.Preview.enableTabs = function(textarea) {
	var tabs = textarea.parents('.tab_container').prev('ul.tabs').find('li');
	var tab_contents = textarea.parents('.tab_container').find('.tab_content');

	tab_contents.hide();

	// show first tab
	tabs.first().addClass("active").show();
	tab_contents.first().show();
}

PuzzleNode.Preview.convertMarkdown = function(tab) {
  var text = tab.find('textarea').val();
  tab.filter('#preview').html("<p>Loading ...</p>");

	$.post("/markdown/parse.text", { text: text },
	  function(data){
      tab.filter('#preview').html(data);
	  });
}