# ![Armor](res/logo.png)

Infra-structure for ditributed/remote configuration of a grid of nodes.

## Concepts

* Namespace - A context for which various nodes may be configured (eg: a corporation)
* Node - A piece of hardware able to perform computation (eg: desktop computer, notebook)
* Configuration - Step included in the node's boot where it gathers files and data to configure itself
* Armord node - Special node that stores/manages the configuration (files and data) for each node
