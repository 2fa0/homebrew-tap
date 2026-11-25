class AgyVitals < Formula
  desc "Real-time macOS Notch, Desktop Panel & CLI Statusline for Google Antigravity"
  homepage "https://github.com/2fa0/agy-vitals"
  version "0.5.3"

  on_macos do
    on_arm do
      url "https://github.com/2fa0/agy-vitals/releases/download/v0.5.3/agy-statusline-macos-arm64.tar.gz"
      sha256 "280ec6b2b9c2f0429673868a19bb28502334e356cad26fe50287aa3e58402c48"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/2fa0/agy-vitals/releases/download/v0.5.3/agy-statusline-linux-x64.tar.gz"
      sha256 "2f4b9801e3ccee914a4b7441c9bd788ad2dbc672222c097d7aa8fd3e03ccc59f"
    end
    on_arm do
      url "https://github.com/2fa0/agy-vitals/releases/download/v0.5.3/agy-statusline-linux-arm64.tar.gz"
      sha256 "089a0bf06cdee79302aa9bf7263e6452612bc6a497d55c8c4d330cea5c7b39a0"
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
