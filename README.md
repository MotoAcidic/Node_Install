![Node Install](https://github.com/MotoAcidic/Node_Install/blob/master/Graphics/NodeInstall.png)
[![GitHub license](https://img.shields.io/github/license/Naereen/StrapDown.js.svg)](https://github.com/Naereen/StrapDown.js/blob/master/LICENSE)

## What is Node Install
Node Install is a collection of Masternode Projects and other projects that allows you to either compile from source for your masternode instance or
compile from source for your windows exe file. 
The reason for compiling from source is to eliminate the risk of downloading an infected release file that has ran wild through the Cryto Community.

### Installation
As a warning this will take a good amount of time since you will be compiling your own daemon and not using the provided one by the project.
For first time running the this use command bellow:

```
git clone https://github.com/MotoAcidic/Node_Install.git && cd Node_Install && bash install.sh
```

For returning users we will delete this repo and get a clean instance of it to keep it fully up to date:

```
rm -rf Node_Install && git clone https://github.com/MotoAcidic/Node_Install.git && cd Node_Install && bash install.sh
```

## Add A Project
There is a few areas that need to be added in order for your project to be added to Node Install.
- Copy one of the coins folder under 
```
Node_Install/Coins 
Example: Node_Install/Altbet
```
- Rename that folder to your coin and open the specs file.
- Edit the specs listed in the example below to your coins specs.
```
RPC_PORT=9322
COIN_PORT=8322
COIN_NAME='Altbet'
REPO_NAME='abet'
COIN_DAEMON='altbetd'
COIN_CLI='altbet-cli'
COIN_QT='altbet-qt'
GITHUB=https://github.com/altbet/abet
```
- Add your project to the install option scripts located in:
```
Node_Install/Scripts
```
Most coins will use the following scripts:
```
MasternodeInstall.sh
MasternodeUpdate.sh
CompileWindows.sh
```
- Add your coins logo to 
```
Node_Install/Graphics
```
- Add the logo path to the supported coins document located here:
```
Node_Install/Docs/README.md
```

### All documents
All guides and help documents can be found here: [Documentation](https://github.com/MotoAcidic/Node_Install/tree/master/Docs)
All Supported projects can be found in the Documentation folder as well.

**Have fun, this is crypto after all!**

```
BTC  39jrS2CNyPxKiJJSwWF1UuvzH4d8SL33tt
```

![TFinch's github stats](https://github-readme-stats.vercel.app/api?username=MotoAcidic&show_icons=true&title_color=fff&icon_color=79ff97&text_color=9f9f9f&bg_color=151515)


Feel free to use my reflink to signup and receive a bonus w/ vultr:

<a href="https://www.vultr.com/?ref=6903922"><img src="https://www.vultr.com/media/banner_2.png" width="468" height="60"></a>
