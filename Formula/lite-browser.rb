class LiteBrowser < Formula
  desc "Lightweight native macOS web browser with Google search and DNS self-repair"
  homepage "https://github.com/Zeshan495/lite-browser"
  url "https://github.com/Zeshan495/lite-browser/archive/refs/tags/v1.0.5.tar.gz"
  version "1.0.5"
  sha256 "95a6093dc3e52636bc3c9d549e145e076ec48c476fc6034ad3bbee119939e280"
  license "MIT"
  head "https://github.com/Zeshan495/lite-browser.git", branch: "main"

  depends_on macos: :monterey

  def install
    system "make", "build", "VERSION=#{version}"
    prefix.install "build/LiteBrowser.app"
    libexec.install "litebrowser"
    (bin/"litebrowser").write <<~SH
      #!/bin/sh
      LITEBROWSER_APP="#{opt_prefix}/LiteBrowser.app" exec "#{opt_libexec}/litebrowser" "$@"
    SH
  end

  def caveats
    <<~EOS
      Launch from the terminal:   litebrowser            (or: litebrowser apple.com / litebrowser best pizza)
      Add it to Launchpad/Dock:   ln -sf #{opt_prefix}/LiteBrowser.app /Applications/LiteBrowser.app
    EOS
  end

  test do
    assert_predicate prefix/"LiteBrowser.app/Contents/MacOS/LiteBrowser", :executable?
  end
end
