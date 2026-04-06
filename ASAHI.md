## Common issues

### Display notch

The solution **used** to be adding `apple_dcp.show_notch=1` to `GRUB_CMDLINE_LINUX_DEFAULT`
in file `/etc/default/grub`. In my test, this no longer works as of March 2026.

The solution that worked for me is adding `appledrm.show_notch=1` instead.

### Function keys

By default, Fn key needs to be pressed to type F1-12.

Change this by adding `options hid_apple fnmode=2` in file `/etc/modprobe.d/hid_apple.conf`.

Reboot.

* 0 -> Only the F1-F12 keys will work, the multimedia keys will be disabled and the fn key 
will do nothing
* 1 -> The default behaviour, the function keys will work as their multimedia parts and 
the F1-F12 will be acessible through fn
* 2 -> The reverse behaviour (my desided option) the function keys will do their default 
F1-F12 and the multimedia keys will be acessible trought the fn key.


### Command and Option keys

To flip these two keys on an Apple keyboard, run the following commands:

```bash
echo "options hid_apple swap_opt_cmd=1" | sudo tee -a /etc/modprobe.d/hid_apple.conf
```

You may or may not need to run the one below

```bash
sudo dracut --regenerate-all --force
```

Reboot.

## Open questions

### Battery drain on system sleep

Overnight, battery drained about 30% while the system is in sleep.

### USB-C thunderbolt docking station

Does this work?

## Developing

### Build Linux kernel

Create the build directory in Linux source repository.
```
mkdir -p build
```

Merge configs for Asahi build.
```
scripts/kconfig/merge_config.sh -O build \
arch/arm64/configs/defconfig \
arch/arm64/configs/asahi.config
```

Finalize the build config.
```
make O=build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- olddefconfig
```

Build the kernel.
```
  make -j"$(nproc)" O=build ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
    Image.gz dtbs modules
```

Main outputs are the following.
- build/vmlinux
- build/arch/arm64/boot/Image.gz
- build/arch/arm64/boot/dts/apple


### Editor support

Generate clangd config in the build directory.
```
python3 scripts/clang-tools/gen_compile_commands.py \
-d build \
-o build/compile_commands.json
```

