# Written by tools/package.py in IAmAStealer/Bashou at each release: changes here are overwritten.
class Bashou < Formula
  desc "Pet in your terminal that grows as you learn bash (psst: bashou pony hay)"
  homepage "https://github.com/IAmAStealer/Bashou"
  url "https://github.com/IAmAStealer/Bashou/releases/download/v0.12.1/bashou-0.12.1.tar.gz"
  sha256 "b1dd78aeb43723d5a2cc3b53864a6e32839304825ead12f771b072e3af461603"
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
