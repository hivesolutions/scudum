# Example scripts

## Building

### Basics

#### Mounting the repository share

```bash
scudum mount
```

#### Building and deploying to repository

```bash
DEPLOY=1 scudum make.usb
```

#### Using the basic kernel version

```bash
KVARIANT=basic scudum make.usb
```

### Kernel

#### Build the basic version of the kernel and deploy

```bash
VARIANT=basic DEPLOY=1 kernel.build
```

#### Build the basic version of the 4.19.67 kernel and deploy

```bash
MAJOR=5.x MINOR=5.4.44 VARIANT=basic DEPLOY=1 kernel.build
```
