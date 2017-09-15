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

# process.env.PATH = ["/usr/local/bin", process.env.PATH].join(":")

atom.commands.add '.workspace', 'github:stage-and-commit', ->
  workspace = atom.views.getView atom.workspace
  atom.commands.dispatch(workspace, 'github:toggle-git-tab-focus')

  setTimeout (->
    github = document.querySelector('.github-Panel')
    atom.commands.dispatch(github, 'github:stage-all-changes');
    atom.commands.dispatch(github, 'github:commit');
    return
  ), 140
