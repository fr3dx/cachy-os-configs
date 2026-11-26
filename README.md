# CachyOS Configs

## Installation

### Desktop and login

```bash
sudo pacman -Syu --needed niri noctalia alacritty greetd noctalia-greeter gnome-keyring
```

### Applications

```bash
sudo pacman -S --needed newsflash libreoffice-fresh libreoffice-fresh-hu mpv papers loupe
```

### Desktop utilities

```bash
sudo pacman -S --needed cava snapper gpu-screen-recorder paru
paru -S --needed bibata-cursor-theme
```

### Optional AMD CPU power monitoring

```bash
sudo pacman -S --needed dkms
paru -S --needed zenergy-dkms-git
```

### Optional ComfyUI with ROCm

```bash
sudo pacman -S --needed podman rocminfo
podman pull docker.io/yanwk/comfyui-boot:rocm
```
