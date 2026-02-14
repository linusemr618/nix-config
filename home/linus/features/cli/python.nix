{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Python with common packages
    (python3.withPackages (p: with p; [
      # GUI
      tkinter
      
      # Development tools
      pip
      setuptools
      wheel
      virtualenv
      
      # Common utilities
      requests
      black
      pylint
      pytest
      ipython
    ]))
    
    # Python tools
    poetry  # Dependency management
    ruff    # Fast Python linter
  ];
  
  # Python development environment
  home.sessionVariables = {
    PYTHONDONTWRITEBYTECODE = "1";  # Don't create __pycache__
  };
}
