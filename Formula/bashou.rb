# Written by tools/package.py in IAmAStealer/Bashou at each release: changes here are overwritten.
class Bashou < Formula
  desc "Pet in your terminal that grows as you learn bash (psst: bashou pony hay)"
  homepage "https://github.com/IAmAStealer/Bashou"
  url "https://github.com/IAmAStealer/Bashou/releases/download/v0.12.3/bashou-0.12.3.tar.gz"
  sha256 "ee4fbc7067a3b22848567d50a088cc5550c1cc2bac1a1c2b2ac04c0cc956707f"
  license "MIT"

  depends_on "python@3.15"

  def install
    libexec.install Dir["*"]
    libexec.install_symlink Formula["python@3.15"].opt_bin/"python3.15" => "python"
    (bin/"bashou").write <<~SH
      #!/bin/sh
      exec "#{opt_libexec}/python" "#{opt_libexec}/launch.py" bashou "$@"
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
