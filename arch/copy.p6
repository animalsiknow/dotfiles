#!/usr/bin/env perl6

my %files = <
  boot/loader/entries/arch.conf /boot/loader/entries/arch.conf
  etc/makepkg.conf /etc/makepkg.conf
  etc/X11/xorg.conf.d/20-nvidia.conf /etc/X11/xorg.conf.d/20-nvidia.conf
  etc/X11/xorg.conf.d/80-screen.conf /etc/X11/xorg.conf.d/80-screen.conf
  etc/X11/xorg.conf.d/90-monitor.conf /etc/X11/xorg.conf.d/90-monitor.conf
  etc/libvirt/qemu.conf /etc/libvirt/qemu.conf
  etc/mkinitcpio.conf /etc/mkinitcpio.conf
  etc/pacman.conf /etc/pacman.conf
>;

for %files.kv -> $source, $target {
    qq{Copying "$source" -> "$target".}.say;
    $source.IO.copy($target.IO);
}
