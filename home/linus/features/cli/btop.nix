{ ... }: {
  programs.btop = {
    enable = true;
    settings = {
      # Theme
      color_theme = "Default";
      theme_background = false;
      
      # Display
      vim_keys = true;
      rounded_corners = true;
      graph_symbol = "braille";
      
      # Update frequency
      update_ms = 1000;
      
      # Show process details
      proc_tree = false;
      proc_sorting = "cpu lazy";
      proc_reversed = false;
      proc_aggregate = false;
      
      # CPU
      cpu_graph_upper = "total";
      cpu_graph_lower = "total";
      cpu_single_graph = false;
      
      # Memory
      mem_graphs = true;
      
      # Network
      net_auto = true;
      net_sync = true;
      
      # Disk
      show_disks = true;
      show_io_stat = true;
      io_mode = true;
    };
  };
}
