# Building the VMware greengrass OVA

## Prerequisites

1. VMware ESXi or vSphere system
1. govc command available from [govc]
1. packer available from [packer]
1. Download greengrass 1.3 code from AWS

## First prepare your ESXi host

1. Enable ssh via the ESXi console
1. Enable the "Guest IP Hack" which will enable packer to infer the IP address
   of the guest.
   
	```esxcli system settings advanced set -o /Net/GuestIPHack -i 1```
1. Enable VNC access for packer

Modify the firewall rules to add 

```
chmod 644 /etc/vmware/firewall/service.xml
chmod +t /etc/vmware/firewall/service.xml
```

Add this to /etc/vmware/firewall/service.xml
```
<service id="1000">
  <id>packer-vnc</id>
  <rule id="0000">
    <direction>inbound</direction>
    <protocol>tcp</protocol>
    <porttype>dst</porttype>
    <port>
      <begin>5900</begin>
      <end>5964</end>
    </port>
  </rule>
  <enabled>true</enabled>
  <required>true</required>
</service>
```

And restart the firewall service
```
chmod 444 /etc/vmware/firewall/service.xml
esxcli network firewall refresh
```

## Create the OVA image

To create the OVA image there is a Makefile for the steps.

1. cp vars-sample.json vars.json
1. Edit vars.json for your ESXi installation
1. ```make build```

## Import back into ESXi

To import the new OVA back, run this command:

```govc import.ova -name testgcc VMware-ubuntu-ggc.ova```


## Login

The login/password for the VMware-ubuntu-ggc OVA image is ggc/ggc. Please change this password after logging in.


[govc]: https://github.com/vmware/govmomi
[packer]: https://www.packer.io/
