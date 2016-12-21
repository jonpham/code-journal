function initializeCodeEditor() {
  var editor = ace.edit("editor");
  editor.getSession().setUseWorker(false);
  editor.setTheme("ace/theme/monokai");
  editor.getSession().setMode("ace/mode/ruby");
}

initializeCodeEditor();
