class AgyVitals < Formula
  desc "Real-time macOS Notch, Desktop Panel & CLI Statusline for Google Antigravity"
  homepage "https://github.com/2fa0/agy-vitals"
  version "0.5.4"

  on_macos do
    depends_on arch: :arm64

    url "https://github.com/2fa0/agy-vitals/releases/download/v0.5.4/agy-statusline-macos-arm64.tar.gz"
    sha256 "80ff65f95d4b080f1393ea7315c113034f3b7674a74f9a6d2d68d79b66f2f437"
  end

  on_linux do
    on_intel do
      url "https://github.com/2fa0/agy-vitals/releases/download/v0.5.4/agy-statusline-linux-x64.tar.gz"
      sha256 "6003a4fbde5cf8dd5a37c7ca0bbe3f8f8642a789db53f7e68ec8afdfb2383063"
    end
    on_arm do
      url "https://github.com/2fa0/agy-vitals/releases/download/v0.5.4/agy-statusline-linux-arm64.tar.gz"
      sha256 "b1bb17fd2f5f75bb30ce91ace9c406ed63af58210bbdca883d6451af58966f94"
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
