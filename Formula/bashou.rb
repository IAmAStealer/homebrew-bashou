# Written by tools/package.py in IAmAStealer/Bashou at each release: changes here are overwritten.
class Bashou < Formula
  desc "Pet in your terminal that grows as you learn bash (psst: bashou pony hay)"
  homepage "https://github.com/IAmAStealer/Bashou"
  url "https://github.com/IAmAStealer/Bashou/releases/download/v0.12.2/bashou-0.12.2.tar.gz"
  sha256 "914d3cf8d55de4a45535fad1faace99c66ca15a639c5006ae02af6bad504f889"
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
