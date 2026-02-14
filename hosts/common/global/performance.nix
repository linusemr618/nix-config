{ ... }: {
  # Performance tuning configurations
  boot.kernel.sysctl = {
    # Memory management - prefer RAM over swap
    "vm.swappiness" = 10;
    "vm.vfs_cache_pressure" = 50;
    
    # Network performance
    "net.core.netdev_max_backlog" = 5000;
    "net.core.rmem_max" = 16777216;
    "net.core.wmem_max" = 16777216;
    "net.ipv4.tcp_rmem" = "4096 87380 16777216";
    "net.ipv4.tcp_wmem" = "4096 65536 16777216";
    
    # Enable TCP Fast Open
    "net.ipv4.tcp_fastopen" = 3;
    
    # File system performance
    "fs.inotify.max_user_watches" = 524288;
  };
}
