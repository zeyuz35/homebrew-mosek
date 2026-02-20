class Copt < Formula
  desc "Cardinal Optimizer - mathematical optimization solver"
  homepage "https://github.com/COPT-Public/COPT-Release"
  url "https://pub.shanshu.ai/download/copt/8.0.3/osx64/CardinalOptimizer-8.0.3-universal_mac.tar.gz"
  # version "8.0.3"
  sha256 "f340bfde55a7e9e17cbe8be5e8699936eab4232f8565404f92237f47f58bbca5"

  def install
    # The tarball extracts directly to the build directory
    # Install all contents to libexec
    prefix_dir = buildpath.children.first
    
    if prefix_dir.directory?
      # If tarball contains a single directory, install its contents
      libexec.install Dir[prefix_dir/"*"]
    else
      # If tarball extracts files directly, install them
      libexec.install Dir["*"]
    end
    
    # Create symlinks for binaries to Homebrew's bin directory
    bin.install_symlink Dir[libexec/"bin/*"]
    
    # Create symlinks for libraries to Homebrew's lib directory
    Dir[libexec/"lib/*"].each do |lib_file|
      lib.install_symlink lib_file
    end
    
    # Create symlinks for include files if they exist
    if (libexec/"include").exist?
      Dir[libexec/"include/*"].each do |include_file|
        include.install_symlink include_file
      end
    end
  end

  def caveats
    <<~EOS
      COPT has been installed to:
        #{opt_libexec}

      Environment variables (add to your shell profile):
        export COPT_HOME=#{opt_libexec}
        export COPT_LICENSE_DIR=$HOME/copt
        export DYLD_LIBRARY_PATH=#{opt_lib}:$DYLD_LIBRARY_PATH

      The copt binary is already available in your PATH via Homebrew.

      ⚠️  LICENSE REQUIRED ⚠️
      To use COPT, you must obtain a license:
        1. Apply for a license at: https://www.shanshu.ai/copt
        2. You will receive license.dat and license.key files
        3. Place these files in one of the following locations:
           • $HOME/copt/license.dat and $HOME/copt/license.key (recommended)
           • Set COPT_LICENSE_DIR to a custom directory containing the license files

      For more information, visit:
        https://guide.coap.online/copt/en-doc/index.html
    EOS
  end
end
