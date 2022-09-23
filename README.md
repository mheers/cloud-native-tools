# Cloud native tools

> Cloud native tools: packs most common (very opinionated) tools into a single docker image.

## Usage

Use in combination with [igor](https://github.com/mheers/igor) to run commands in the container.

```bash
sudo curl https://raw.githubusercontent.com/mheers/igor/master/igor.sh -o /usr/local/bin/igor
sudo chmod +x /usr/local/bin/igor
```

Copy [.igor.sh](.igor.sh) to ~/.igor.sh or (better) link it: ```ln -s $(pwd)/getting-started/.igor.sh ~/.igor.sh```


# TODO:
- [ ] make igor work with [kubecfgx](https://github.com/mheers/kubecfgx)
