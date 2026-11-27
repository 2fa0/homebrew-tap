class AgyVitals < Formula
  desc "Real-time macOS Notch, Desktop Panel & CLI Statusline for Google Antigravity"
  homepage "https://github.com/2fa0/agy-vitals"
  version "0.5.5"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/2fa0/agy-vitals/releases/download/v0.5.5/agy-statusline-macos-arm64.tar.gz"
    sha256 "abf6e8a48bda637bfbbbd88ee07523ce0717a49b54e3efa8554951e1be6f27f1"
  end

  on_linux do
    on_intel do
      url "https://github.com/2fa0/agy-vitals/releases/download/v0.5.5/agy-statusline-linux-x64.tar.gz"
      sha256 "c7b80b159071c800d44242a91f780fa0146883e88309894ea0e426c6e453d17c"
    end
    on_arm do
      url "https://github.com/2fa0/agy-vitals/releases/download/v0.5.5/agy-statusline-linux-arm64.tar.gz"
      sha256 "acaf1c0755a1ac1459597a2273b3932e878fc98a27e762ea3ea262d6710e23fe"
    end
  end

  def install
    libexec.install "agy-statusline"
    libexec.install "sidecars" if (buildpath/"sidecars").exist?
    bin.write_exec_script libexec/"agy-statusline"
  end

  def caveats
    <<~EOS
      To enable the CLI status line (and macOS Notch on macOS 13+), add to ~/.gemini/antigravity-cli/settings.json:
        {
          "statusLine": {
            "type": "command",
            "command": "#{opt_bin}/agy-statusline",
            "stack_with_default": true
          }
        }

      To also install the Antigravity 2.0 Desktop right-pane plugin:
        curl -fsSL https://raw.githubusercontent.com/2fa0/agy-vitals/main/install.sh | bash -s -- --panel-only
    EOS
  end

  test do
    assert_match "agy-statusline #{version}", shell_output("#{bin}/agy-statusline --version")
  end
end
