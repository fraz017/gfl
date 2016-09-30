CKEDITOR.plugins.add( 'attachment', {
icons: 'attachment',
init: function( editor ) {
    editor.addCommand( 'attachmentDialog', new CKEDITOR.dialogCommand( 'attachmentDialog') );
    editor.ui.addButton( 'attachment', {
        label: 'File',
        command: 'attachmentDialog',
        toolbar: 'insert'
    });

    CKEDITOR.dialog.add( 'attachmentDialog', this.path + 'dialogs/attachment.js' );
	}
});