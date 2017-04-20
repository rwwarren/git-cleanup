# git-cleanup

This is a script designed for oh-my-zsh to update and prune all your git projects.

## Setup
1. download cleanup.plugin.zsh and move it to the oh-my-zsh custom plugin folder under a new directory called "cleanup"
(.oh-my-zsh/custom/plugins/cleanup)
2. Change the "repoLocation" from "" to wherever your directory with all your git repos are
3. Enable the plugin through the zshrc by adding "cleanup" to the plugins section

The enabled plugins might look like this:
`plugins=(git cleanup)`
