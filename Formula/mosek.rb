class Mosek < Formula
  desc "Mosek optimization software"
  homepage "https://www.mosek.com/"
  url "https://download.mosek.com/stable/11.1.6/mosektoolsosxaarch64.tar.bz2"
  sha256 "a8ef4cbadedf3b442facf93aca8b4e8bb9eeb908c0d2c29c9382cfa57d7d4b63"
  license ""

  def install
    # Extract and install mosek
    prefix.install Dir["*"]
    
    # Link mosek bin directory to homebrew bin directory
    bin.install_symlink prefix/"11.1/tools/platform/osxaarch64/bin" => "mosek_bin"
    Dir["#{prefix}/11.1/tools/platform/osxaarch64/bin/*"].each do |file|
      next if File.directory?(file)
      bin.install_symlink file => File.basename(file)
    end
    
    # Link header files to homebrew include directory
    Dir["#{prefix}/11.1/tools/platform/osxaarch64/h/*.h"].each do |header|
      include.install_symlink header => File.basename(header)
    end
  end

  def post_install
    puts "Mosek installed successfully!"
    puts "Set MOSEKPLATFORM=osx64x86 in your environment if needed"
    puts ""
    puts "⚠️  License Required: Mosek requires a license file to run."
    puts "Please request a license from https://www.mosek.com/products/mosek/"
    puts "and place the license file in #{ENV['HOME']}/mosek/mosek.lic"
    puts ""
    puts "Running Mosek installation script to set up Python bindings..."
    system "python", "#{prefix}/11.1/tools/platform/osxaarch64/bin/install.py"
  end

  test do
    system "#{bin}/mosek", "-v"
  end
end