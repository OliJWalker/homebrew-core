class Jena < Formula
  desc "Framework for building semantic web and linked data apps"
  homepage "https://jena.apache.org/"
  url "https://www.apache.org/dyn/closer.lua?path=jena/binaries/apache-jena-4.3.0.tar.gz"
  mirror "https://archive.apache.org/dist/jena/binaries/apache-jena-4.3.0.tar.gz"
  sha256 "ee1746625b0932892c2582a2cd136558718d70ea0eeae7a2800c1d9fd52e2a82"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "6fd892d748caed8e671fab9baf71b0f978bf9c883a7d08f2a1e1962fe4ca11dc"
  end

  depends_on "openjdk"

  def install
    env = {
      JAVA_HOME: Formula["openjdk"].opt_prefix,
      JENA_HOME: libexec,
    }

    rm_rf "bat" # Remove Windows scripts

    libexec.install Dir["*"]
    Pathname.glob("#{libexec}/bin/*") do |file|
      next if file.directory?

      basename = file.basename
      next if basename.to_s == "service"

      (bin/basename).write_env_script file, env
    end
  end

  test do
    system "#{bin}/sparql", "--version"
  end
end
