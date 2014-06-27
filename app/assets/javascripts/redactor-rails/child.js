if (typeof RedactorPlugins === 'undefined') var RedactorPlugins = {};

RedactorPlugins.child = {
    init: function ()
    {
        this.buttonAdd('child', 'Insert Child Chapter', this.child);
    },
    child: function(buttonName, buttonDOM, buttonObj, e)
    {
        this.insertHtml('<p><a href="" data-chapter="{link_to_child_chapter:}">Go to chapter</a></p>');
    }
};