# FreeIPA double master on CentOS7

## require

- To be several packages installed.
 - `Ansible`
 - `Serverspec`
 - `ansible_spec`
- To set login configuration to `~/.ssh/config` for servers.

## test

```
$ rake -T    # show available targets
$ rake serverspec:aaa1_as_IPA_master
$ rake serverspec:aaa2_as_IPA_replica
```

## provision

```
$ ansible-playbook -i hosts site.yml
```
