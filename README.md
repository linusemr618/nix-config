# nix-config
My personal NixOS configuration

## Swapfile with Hibernation Support

This configuration includes a swapfile setup for btrfs filesystems with hibernation support.

### Initial Setup

The swapfile is configured in `hosts/common/global/swap.nix` with:
- 16GB swap size (suitable for systems with 8-16GB RAM)
- Copy-on-Write (CoW) disabled for btrfs compatibility
- Hibernation resume configuration

### Enabling Hibernation

After the first boot with this configuration:

1. **Calculate the swap offset:**
   ```bash
   sudo btrfs inspect-internal map-swapfile -r /var/swapfile
   ```

2. **Update the configuration:**
   Edit `hosts/common/global/swap.nix` and replace `resume_offset=0` with the actual value from step 1:
   ```nix
   boot.kernelParams = [
     "resume_offset=<your_calculated_offset>"
   ];
   ```

3. **Rebuild the system:**
   ```bash
   sudo nixos-rebuild switch
   ```

4. **Test hibernation:**
   ```bash
   systemctl hibernate
   ```

### Notes

- The swapfile is located at `/var/swapfile`
- Swapfile size can be adjusted by modifying the `size` parameter in `swap.nix`
- For hibernation to work, the swap must be at least as large as your RAM

