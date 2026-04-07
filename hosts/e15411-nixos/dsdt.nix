{pkgs, ...}: let
  acpiOverride =
    pkgs.runCommand "acpi-override" {
      nativeBuildInputs = [pkgs.acpica-tools pkgs.cpio];
    } ''
      mkdir -p kernel/firmware/acpi
      iasl -p kernel/firmware/acpi/dsdt ${./dsdt.dsl}
      find kernel -print0 | cpio --null -H newc -o -R root:root > $out
    '';
in {
  boot.initrd.prepend = ["${acpiOverride}"];
}
