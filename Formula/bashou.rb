# Written by tools/package.py in IAmAStealer/Bashou at each release: changes here are overwritten.
class Bashou < Formula
  desc "Pet in your terminal that grows as you learn bash (psst: bashou pony hay)"
  homepage "https://github.com/IAmAStealer/Bashou"
  url "https://github.com/IAmAStealer/Bashou/releases/download/v0.10.6/bashou-0.10.6.tar.gz"
  sha256 "aaa9e6e9583695c76e98ee13d993273665ef3de4ba08c11ffc7ef64993764308"
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
