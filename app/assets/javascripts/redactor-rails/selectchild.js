var RLANG = {};

if (typeof RedactorPlugins === 'undefined') {
    var RedactorPlugins = {};
}

RedactorPlugins.selectChild = {
    init: function() {
        this.buttonAdd('selectChild', "Select Child", function(){
        	this.createModal()
        });

        //Add a separator before the button
        this.buttonAddSeparatorAfter('selectChild');
    },
    createModal: function() {
        "use strict";

        var that = this;
        this.modalInit(RLANG.emoticons, "#chapter-list", 300, function() {
            $('select#child_chapter').change(function() {
                that.bufferSet();
                that.insertHtml('<p>Go to chapter [link_to_chapter ' + $(this).val() + ']</p>');
                that.modalClose();
            });
        });
    }
};