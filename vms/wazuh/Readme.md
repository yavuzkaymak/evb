# Wazuh Installation

This stack provisions two VMs, one for wazuh-server another for wazuh-agent. The VMs are connected via a host-only network. The server has the IP of 192.168.100.10 and the agent 192.168.100.11.\

## How to start the VMs

```
vagrant up
```

## How to modify the VMs

VMs are configured using ansible. If you want to add or remove something, it is higly recommended to use the respective ansible playbooks.

After you make the desired changes in ansible-playbook

```
vagrant up wazuh-<agent | server> up --provision
```

After you start the machines wazuh-server will be reachable throrugh the browser

```
https://192.168.100.10
```

username: admin \
password: SecretPassword

The agent will expose an index.html with apache2 at port 80

```
http://192.168.100.11
```
