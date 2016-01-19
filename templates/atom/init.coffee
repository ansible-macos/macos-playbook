# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"
{extname} = require 'path'

fileTypes =
  '.swig' : 'text.html.twig'

atom.workspace.observeTextEditors (editor) ->
  scopeName = fileTypes[extname editor.getPath()]
  return unless scopeName?
  g =  atom.grammars.grammarForScopeName scopeName
  return unless g?
  editor.setGrammar g

process.env.PATH = ["/usr/local/bin", process.env.PATH].join(":")
