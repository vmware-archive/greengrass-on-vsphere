

# greengrass-on-vsphere

## Overview
This repository contains information on AWS Greengrass on vSphere. There are:
- the scripts for building the AWS Greengrass on vSphere OVA image
- instructions on how to install it and a walkthrough of an example using AWS Greengrass on vSphere

## Building the AWS Greengrass on vSphere OVA
Most users will download the prebuilt image. For those wanting to replicate or modify this image use instructions [here](packer/README.md).

## Installing the AWS Greengrass on vSphere OVA
1. The OVA can be imported into vSphere, ESXi, Fusion, or Workstation
1. Once booted, login to the image as user ```ggc``` and the default password ```ggc```. 
1. Important: Run ```passwd``` to change the default ggc user password.

## Starting Greengrass Core
In order to start the Greengrass core the core must be created with AWS with credentials created and installed with it. These credentials will allow the core to securely connect into your AWS account via the Greengrass service.

The documentation will explain two ways to start the Greengrass core.
1. [Using the AWS UI](#using-the-aws-ui)
1. [Using the gghelper utility](#using-the-gghelper-utility)

### Using the AWS UI

#### Start Greengrass using the AWS UI
1. Login to AWS IoT web UI and create a Greengrass group and core, and
   download the core's certificate, public and private keys, and config.json as a tar.gz.  
1. Download the tar.gz to the VM appliance and unpack the contents to the
  /greengrass folder.
  ```sudo tar xf gg-setup.tar.gz -C /greengrass```
1. Verify that the certificates have been installed.  
   ```ls /greengrass/certs```
1. Verify that the config.json is properly configured.  
   ```cat /greengrass/config/config.json```
1. Install the Symantec Verisign root CA certificate onto the VM appliance.  
   ```sudo wget -O /greengrass/certs/root.ca.pem "http://www.symantec.com/content/en/us/enterprise/verisign/roots/VeriSign-Class%203-Public-Primary-Certification-Authority-G5.pem"```
1. Start greengrass!  
```sudo /greengrass/ggc/core/greengrassd start```

### Example using the UI
1. Further instructions for a UI walkthrough can be found [here](https://docs.aws.amazon.com/greengrass/latest/developerguide/module3-I.html).

### Using the gghelper utility

#### Start Greengrass using the gghelper utility
1. Ensure you have AWS development credentials setup on the Linux system being used.
   Instructions can be found [here](https://docs.aws.amazon.com/sdk-for-java/v1/developer-guide/setup-credentials.html).
1. Download the gghelper utility [here](https://github.com/cloudtools/gghelper/releases). Make sure the downloaded file is made executable and, for the purposes of these instructions, rename to gghelper and put it in your binary path.
1. Create a Greengrass group and generate the certificates.  
```gghelper creategroup -name test```  
The creategroup command will generate a tar file containing the certificates and configuration
for the Greengrass Core. This should be transferred onto the GGC system and unpacked. Note: the filename is based on the certificate so your filename will be different.  
```tar xzf 5d7b82589d-setup.tar.gz -C /greengrass```
1. The Greengrass core can be started with this configuration.  
```(cd /greengrass/ggc/core; sudo ./greengrassd start)```

#### Example using gghelper
1. Add in a lambda function  
```gghelper lambda -pinned -d dist -handler hello_vsphere.hello_vsphere_handler -name HellovSphere -role lambda-test-get -runtime python2.7```
1. Create a subscription between the function and cloud  
```gghelper createsub -source HellovSphere -target cloud -subject "hello/vsphere"```
1. Make a deployment to download config and code to the Greengrass core  
```gghelper createdeployment```
1. Going to the Greengrass Test page, create a subscription (using # will get all the messages) to see the function run periodically every 5 seconds.

## Contributing

The greengrass-on-vsphere project team welcomes contributions from the community. Before you start working with greengrass-on-vsphere, please read our [Developer Certificate of Origin](https://cla.vmware.com/dco). All contributions to this repository must be signed as described on that page. Your signature certifies that you wrote the patch or have the right to pass it on as an open-source patch. For more detailed information, refer to [CONTRIBUTING.md](CONTRIBUTING.md).

## License
greengrass-on-vsphere is licensed under the BSD 2-Clause License.
