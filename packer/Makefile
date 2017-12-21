build:
	packer build -var-file=vars.json ubuntu.json

debug:
	PACKER_LOG=1 PACKER_LOG_PATH="packerlog.txt" packer build -var-file=vars.json -on-error=ask ubuntu.json
	govc export.ovf -vm "VMware-ubuntu-ggc" ova
	(cd ova/VMware-ubuntu-ggc && tar cf ../VMware-ubuntu-ggc.ova .)

import:
	govc import.ova -name testgcc output-ggc/VMware-ubuntu-ggc.ova
