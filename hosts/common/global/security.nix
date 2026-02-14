{ ... }: {
  # Security hardening
  security = {
    # Sudo configuration
    sudo = {
      enable = true;
      execWheelOnly = true;
      wheelNeedsPassword = true;
    };
    
    # Polkit for privilege escalation
    polkit.enable = true;
    
    # Enable AppArmor for additional security
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
    };
    
    # Protect kernel logs
    dmesg.restrict = true;
    
    # Disable ptrace for non-root users (better security, might break some debuggers)
    # Uncomment if you don't need debugging
    # allowUserNamespaces = false;
  };
  
  # Boot security - kernel parameters
  boot.kernel.sysctl = {
    # IP forwarding
    "net.ipv4.ip_forward" = 0;
    "net.ipv6.conf.all.forwarding" = 0;
    
    # Ignore ICMP redirects
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.default.accept_redirects" = 0;
    
    # Ignore send redirects
    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv4.conf.default.send_redirects" = 0;
    
    # Ignore source routing
    "net.ipv4.conf.all.accept_source_route" = 0;
    "net.ipv4.conf.default.accept_source_route" = 0;
    "net.ipv6.conf.all.accept_source_route" = 0;
    "net.ipv6.conf.default.accept_source_route" = 0;
    
    # Protect against SYN flood attacks
    "net.ipv4.tcp_syncookies" = 1;
    
    # Kernel hardening
    "kernel.dmesg_restrict" = 1;
    "kernel.kptr_restrict" = 2;
    "kernel.unprivileged_bpf_disabled" = 1;
    "kernel.unprivileged_userns_clone" = 0;
  };
}
