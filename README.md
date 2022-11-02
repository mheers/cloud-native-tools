# Cloud native tools

> Cloud native tools: packs most common (very opinionated) tools into a single docker image.

## Usage

Use in combination with [igor](https://github.com/mheers/igor) to run commands in the container.

```bash
sudo curl https://raw.githubusercontent.com/mheers/igor/master/igor.sh -o /usr/local/bin/igor
sudo chmod +x /usr/local/bin/igor
```

Copy [.igor.sh](.igor.sh) to ~/.igor.sh or (better) link it: ```ln -s $(pwd)/getting-started/.igor.sh ~/.igor.sh```


## Installed tools
|Tool|Description|
|-|-|
|arkade|One line install of apps|
|bash|Bourne Again SHell|
|bind-tools|DNS Tools|
|cert-manager|Manage cert-manager resources inside your cluster|
|config-registry|Switch between kubeconfig files|
|curl|Curl CLI|
|docker|Manage docker containers|
|exec-as|Like kubectl exec, but offers a 'user' flag to exec as root or any other user|
|file|Magic file type identification library|
|fzf|Fuzzy finder CLI|
|git|Git CLI|
|go|GoLang Programming Language|
|hns|Manage hierarchical namespaces|
|images|Show container images used in the cluster|
|iputils|IP Tools|
|jq|json parser / manipulator|
|k3d|kubernetes cluster manager (k3s on docker)|
|k3droot|Exec as root into a k3d managed pod|
|k9s|kubernetes cluster cli admin tui|
|konfig|Manage kubeconfig files|
|krew|package manager for kubectl plugins|
|krew|Package manager for kubectl plugins|
|kube2pulumi|Convert Kubernetes YAML manifests to Pulumi programs|
|kubectl|kubernetes cli|
|kubectx|kubernetes context manager|
|kubens|kubernetes namespace manager|
|kubeyaml|Validate Kubernetes YAML against schema|
|mob|Mob Programming CLI|
|nano|Simple Text Editor|
|ncurses|Terminal UI Library|
|netcat-openbsd|Swiss Army Knife of Networking|
|nmap|Network Scanner|
|openssh-client|SSH Client|
|pulumi|Infrastructure as Code|
|sudo|Run a command as another user|
|tree|Display directory tree|
|yq|yaml parser / manipulator|
|zsh|ZSH CLI|

# TODO:
- [ ] make igor work with [kubecfgx](https://github.com/mheers/kubecfgx)
