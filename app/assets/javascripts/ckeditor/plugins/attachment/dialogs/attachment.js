CKEDITOR.dialog.add( 'attachmentDialog', function( editor ) {
  return {
    title: 'Upload Document',
    minWidth: 400,
    minHeight: 200,
    contents: [
        {
            id: 'general',
            label: 'Document Info',
            elements: [
                {
                    type: 'text',
                    id: 'txtUrl',
                    label: 'URL',
                    validate: CKEDITOR.dialog.validate.notEmpty( "URL cannot be empty" )
                },
                {
                    type: 'button',
                    hidden: true,
                    id: 'browse',
                    filebrowser: 'general:txtUrl',
                    label: "Use Existing Document",
                    style: 'float:right',
                },
            ]
        },
        {
            id: 'Upload',
            hidden: true,
            filebrowser: 'uploadButton',
            label: editor.lang.image.upload,
            elements: [
                {
                    type: 'file',
                    id: 'upload',
                    label: editor.lang.image.btnUpload,
                    style: 'height:40px',
                    size: 38
                },
                {
                    type: 'fileButton',
                    id: 'uploadButton',
                    filebrowser: 'general:txtUrl',
                    label: "Upload the Document",
                    'for': [ 'Upload', 'upload' ]
                }
            ]
        },
    ],
    onOk: function() {
        var dialog = this;

        //Get the value selected in the editor.
        var selectedText = editor.getSelection().getSelectedText();

        var attachment = editor.document.createElement( 'a' );

        attachment.setAttribute( 'href', dialog.getValueOf( 'general', 'txtUrl' ) );

        //If there isn't anything selected in the editor, default the text to the document url.
        if (selectedText == "") {
            attachment.setText(dialog.getValueOf('general', 'txtUrl'));
        } else {
            attachment.setText(selectedText);
        }

        editor.insertElement(attachment);
    }
  }
});