# Written by tools/package.py in IAmAStealer/Bashou at each release: changes here are overwritten.
class Bashou < Formula
  desc "Pet in your terminal that grows as you learn bash (psst: bashou pony hay)"
  homepage "https://github.com/IAmAStealer/Bashou"
  url "https://github.com/IAmAStealer/Bashou/releases/download/v0.10.0/bashou-0.10.0.tar.gz"
  sha256 "f573c779ae4a200463a199a1355ac1fe1b7e9cd5080d5fd0d90f88eadcbe09e9"
  license "MIT"

  uses_from_macos "python"

  def install
    libexec.install Dir["*"]
    (bin/"bashou").write <<~SH
      #!/bin/sh
      exec python3 "#{opt_libexec}/launch.py" bashou "$@"
    SH
  end

  def caveats
    <<~EOS
      Meet your pet: run `bashou on`, then open a new terminal.
      It adds one line to ~/.zshrc (and ~/.bashrc for a bash 4.4 or newer). `bashou off` hides the pet.
    EOS
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/bashou version")
  end
end
