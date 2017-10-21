(function($)
{
    RedactorPlugins.selectChild = function()
    {
        return {
            init: function()
            {
                var that = this;

                var button = this.button.add('selectChild', 'Select Child');
                this.button.addCallback(button, that.selectChild.show);
            },
            getTemplate: function(){
                content = "<select id='children-chapters'>"; 

                $.each($('#chapter-list select'), function(i,val) {
                    content = content + $(val).html();
                });
                console.log(content);
                return String() + content + "</select>";
            },
            show: function(){
                this.modal.addTemplate('selectChild', this.selectChild.getTemplate());
                this.modal.load('selectChild', 'Select Child', 600);
                
                this.modal.show();
 
                $('select#children-chapters').on('change', this.selectChild.insert);
                $('select#children-chapters').focus();
            },
            load: function(i,s)
            {
                $(s).on('click', $.proxy(function(e)
                {
                    e.preventDefault();
                    this.clips.insert($(s).next().html());

                }, this));
            },
            insert: function(html)
            {
                var html = '<p>Go to chapter [link_to_chapter ' + $('select#children-chapters').val() + ']</p>'
                this.modal.close();
 
                this.buffer.set(); // for undo action
                this.insert.html(html);
                return true;
            }
        };
    };
})(jQuery);