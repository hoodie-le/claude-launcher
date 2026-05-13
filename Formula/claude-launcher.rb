class ClaudeLauncher < Formula
  desc "Open Ghostty with N equal split panes, each running claude in a chosen repo"
  homepage "https://github.com/hoodie-le/claude-launcher"
  url "https://github.com/hoodie-le/claude-launcher/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "REPLACE_ME_WITH_RELEASE_TARBALL_SHA256"
  license "MIT"
  head "https://github.com/hoodie-le/claude-launcher.git", branch: "main"

  depends_on :macos

  def install
    bin.install "bin/claude-launcher"
  end

  test do
    assert_match(/claude-launcher v/, shell_output("#{bin}/claude-launcher --version"))
    assert_match(/USAGE:/, shell_output("#{bin}/claude-launcher --help"))
  end
end
