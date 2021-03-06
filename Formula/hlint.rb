require "language/haskell"

class Hlint < Formula
  include Language::Haskell::Cabal

  desc "Haskell source code suggestions"
  homepage "https://github.com/ndmitchell/hlint"
  url "https://hackage.haskell.org/package/hlint-2.1.4/hlint-2.1.4.tar.gz"
  sha256 "906ef36ff7c6ec1306c6587b23c345c76f67658c4db896fa0f6334fd24b50f07"
  head "https://github.com/ndmitchell/hlint.git"

  bottle do
    sha256 "44ee123511f2e954fa4de78647242dc27c744ee939ea244a367d28d20c224815" => :high_sierra
    sha256 "2b99f7b649dadda4054e2091b1ea74997d14729b4fc416bcf14cd84c8c88c625" => :sierra
    sha256 "2e818686fa267d87137b077f0b621852951439def0141d746ccdfce559587d05" => :el_capitan
  end

  depends_on "cabal-install" => :build
  depends_on "ghc" => :build

  def install
    install_cabal_package :using => "happy"
    man1.install "data/hlint.1"
  end

  test do
    (testpath/"test.hs").write <<~EOS
      main = do putStrLn "Hello World"
    EOS
    assert_match "Redundant do", shell_output("#{bin}/hlint test.hs", 1)
  end
end
