# Written by tools/package.py in IAmAStealer/Bashou at each release: changes here are overwritten.
class Bashou < Formula
  desc "Pet in your terminal that grows as you learn bash (psst: bashou pony hay)"
  homepage "https://github.com/IAmAStealer/Bashou"
  url "https://github.com/IAmAStealer/Bashou/releases/download/v0.10.2/bashou-0.10.2.tar.gz"
  sha256 "353f9a02b3f617cabd557a63485c54453de7079f769834e644d2053e0954a59a"
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
